class CommentsController < ApiController

  include ActionView::Helpers::TextHelper
  include SendgridInbound

  skip_before_action :initialize_user!, only: [:parse_email]
  before_action :set_commentable, except: [:parse_email]
  before_action :set_comment, only: [:update, :destroy]

  before_action :check_ownership_or_ability

  def index
    render json: comments_response
  end

  def create
    @comment = @commentable.comments.create!(create_comment_params)
    handle_mentions
    render json: comments_response
  end

  def update
    @comment.update!(update_comment_params)
    handle_mentions
    render json: comments_response
  end
  
  def destroy
    @comment.update!(archived: true) unless @comment.is_reply
    @comment.destroy! if @comment.is_reply
    render json: comments_response
  end

  def parse_email
    @comment = Comment.new(parse_comment_reply)
    @comment.save! if @comment.valid?
  end

  private

  def handle_mentions
    return unless params[:mentioned]
    receivers = @organization.collaborators_and_guests.where(username: params[:mentioned])
    receivers.each do |receiver|
      notify(receiver, :mention, @comment) 
    end
  end

  def comments_response
    archived = params[:archived] == "true" ? true : false
    { 
      commentable: { id: @parent_model.id, type: @parent_model.class.name },
      comments: serialized(@parent_model.comments.where(archived: archived))
    }
  end
  
  def set_commentable
    commentable_class = Object.const_get(params[:commentable][:type])
    @commentable = commentable_class.find(params[:commentable][:id])
    unless @commentable.organization == @organization
      render_fatal "Unable to comment on a different organization"
    end
    @parent_model = is_reply? ? @commentable.commentable : @commentable
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def create_comment_params
    p = params[:comment]
    p[:user_id] = @user.id
    p[:organization_id] = @organization.id
    p[:text] = simple_format(p[:text])
    p.permit(:user_id, :organization_id, :text)
  end

  def update_comment_params
    p = params[:comment]
    p[:text] = simple_format(p[:text])
    p.permit(:text, :archived)
  end

  def is_reply?
    @commentable.class.name == 'Comment'
  end

  def is_own_comment?
    @comment.user == @user
  end

  def check_ownership_or_ability
    if action_name == 'update'
      # Only owner can edit comment
      deny! unless is_own_comment?
    elsif action_name == 'destroy'
      # Only owner or admin can delete (archived)
      deny! unless is_own_comment? || @user.is_admin? || @user.is_member
    else
      check_ability!
    end
  end

end
