class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @comment = current_user.comments.build comment_params
    @comment = Comment.new if @comment.save
    load_comment params[:id]
    respond_to do |format|
      format.js
    end
  end

  def destroy
    review_id = @comment.comment_id
    if @comment.destroy
      flash[:success] = t "msg.comment_delete_success"
    else
      flash[:danger] = t "msg.comment_delete_fail"
    end
    load_comment review_id
    @comment = Comment.new
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :comment_type, :comment_id,
      :parent_id
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    return if @comment
    flash[:danger] = t "msg.comment_delete_fail"
    redirect_to review_path
  end

  def load_comment id
    @comments = Comment.includes(:user).select_comments(id)
                       .comment_type Settings.review
    @comments_parent = @comments.comment_id(Settings.parent_id_default).newest
    @comment_type = Settings.review
  end
end
