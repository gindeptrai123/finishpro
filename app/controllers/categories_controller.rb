class CategoriesController < ApplicationController
  before_action :load_category, only: :show

  def show
    @reviews = @category.reviews.newest
                        .paginate page: params[:page],
                           per_page: Settings.review_page
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "msg.category_invalid"
    redirect_to root_path
  end
end
