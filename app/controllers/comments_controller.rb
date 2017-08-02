class CommentsController < ApplicationController

  before_action :set_commentable
  before_action :set_comment, only: [:update, :destroy]

  def create
    @commentable.comments.create!(create_comment_params)
    render_success "Comment added", comments
  end

  def update
    @comment.update!(update_comment_params)
    render_success "Comment updated", comments
  end
  
  def destroy
    @comment.destroy!
    render_success "Comment removed", comments
  end

  private

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
    if @commentable.class.name == 'Comment'
      if @commentable.commentable.class.name == 'Comment'
        render_fatal "Maximum comment depth is 1"
      end
    end
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

end
