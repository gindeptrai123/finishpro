class Admin::ReviewsController < AdminController
  before_action :load_review, except: %i(new index create)
  before_action :all_reviews, only: [:index, :destroy]
  before_action :stt, only: :index

  def index; end

  def show; end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:success] = t "msg.create_review_success"
      render :show
    else
      flash[:danger] = t "msg.create_review_fail"
      render :new
    end
  end

  def edit; end

  def update
    @review.update_attributes review_params
    if @review.save
      flash[:success] = t "msg.update_success"
      redirect_to admin_reviews_path
    else
      flash[:danger] = t "msg.update_fail"
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "msg.delete_review_success"
      redirect_to admin_reviews_path
    else
      flash[:danger] = t "msg.delete_review_fail"
      render :index
    end
  end

  private

  def load_review
    @review = Review.find_by id: params[:id]
    return if @review
    flash[:danger] = t "msg.review_invalid"
    redirect_to admin_root_path
  end

  def review_params
    params.require(:review).permit Review::REVIEW_PARAMS
  end

  def all_reviews
    @reviews = Review.newest.paginate page: params[:page],
       per_page: Settings.paginate.reviews
  end

  def stt
    params[:page] = 1 unless params[:page]
    @stt = Settings.paginate.reviews * (params[:page].to_i - 1)
  end
end
