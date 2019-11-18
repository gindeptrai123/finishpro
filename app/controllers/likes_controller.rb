class LikesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy

  def create
    @like = current_user.likes.build review_id: params[:like][:review_id]
    @review = Review.find_by id: params[:like][:review_id]
    respond_to do |format|
      if @review && @like.save
        @liked = @like
        format.js
      else
        format.js{flash[:danger] = t "msg.action_fail"}
      end
    end
  end

  def destroy
    @review = Like.find_by(id: params[:id]).review
    respond_to do |format|
      if @like.destroy
        format.js
      else
        format.js{flash[:danger] = t "msg.action_fail"}
      end
    end
  end

  private

  def correct_user
    @like = current_user.likes.find_by id: params[:id]
    return if @like
    flash[:danger] = t "msg.action_fail"
    redirect_to review_path
  end
end
