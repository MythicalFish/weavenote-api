class CommentsController < ApplicationController

  before_action :set_commentable
  before_action :set_comment, only: [:update, :destroy]

  before_action :check_ability!

  def index
    render json: comments_response
  end

  def create
    @commentable.comments.create!(create_comment_params)
    render_success "Comment added", comments_response
  end

  def update
    @comment.update!(update_comment_params)
    render_success "Comment updated", comments_response
  end
  
  def destroy
    @comment.destroy!
    render_success "Comment removed", comments_response
  end

  private

  def comments_response
    { 
      commentable: @parent_model.class.name,
      comments: serialized(@parent_model.comments.order(created_at: :desc))
    }
  end

  def comments
    c = @commentable
    if c.class.name == 'Comment'
      c = c.commentable
    end
    serialized(c.comments.order(created_at: :desc))
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
    p.permit(:user_id, :organization_id, :text)
  end

  def update_comment_params
    params.require(:comment).permit(:text)
  end

  def is_reply?
    @commentable.class.name == 'Comment'
  end

end
