class ReviewsController < ApplicationController
  before_action :logged_in_user, only: %i(new update edit)
  before_action :load_review, only: %i(show update edit)
  before_action :check_liked, only: :show

  def show
    @comment = Comment.new
    @comments = Comment.includes(:user).select_comments(params[:id])
                       .comment_type Settings.review
    @comments_parent = @comments.comment_id(Settings.parent_id_default).newest
    @comment_type = Settings.review
    @like = Like.new
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:success] = t "msg.create_review_success"
      redirect_to @review
    else
      flash[:danger] = t "msg.create_review_fail"
      render :new
    end
  end

  def edit; end

  def update
    @review.assign_attributes review_params
    if @review.save(context: :update_review)
      flash[:success] = t "msg.update_success"
    else
      flash[:danger] = t "msg.update_fail"
    end
    render :edit
  end

  private

  def load_review
    @review = Review.find_by id: params[:id]
    return if @review
    redirect_to root_path
  end

  def review_params
    params.require(:review).permit Review::REVIEW_PARAMS
  end

  def check_liked
    return unless logged_in?
    @liked = Like.like_review(params[:id]).find_by user_id: current_user.id
  end
end
