class CommentsController < ApplicationController

  before_action :set_commentable
  before_action :set_comment, only: [:update, :destroy]

  def create
    @commentable.comments.create!(comment_params)
    render_success "Comment added", comments
  end

  def update
    @comment.update!(comment_params)
    render_success "Comment updated", comments
  end
  
  def destroy
    @comment.destroy!
    render_success "Comment removed", comments
  end

  private

  def comments
    serialized(@commentable.comments.order('created_at DESC'))
  end

  def set_commentable
    commentable_class = Object.const_get(params[:commentable][:type])
    @commentable = commentable_class.find(params[:commentable][:id])
    unless @commentable.organization == @organization
      render_fatal "Unable to comment on a different organization"
    end
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def comment_params
    p = params[:comment]
    p[:user_id] = @user.id
    p.permit(:user_id, :text)
  end

end
