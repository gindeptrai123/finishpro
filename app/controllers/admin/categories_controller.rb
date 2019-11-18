class Admin::CategoriesController < AdminController
  before_action :load_category, only: %i(destroy edit update)
  before_action :build_category, only: :index
  before_action :all_categories, only: [:index, :edit]
  before_action :stt, only: :index

  def index; end

  def create
    @category = Category.new params_cate
    if @category.save
      flash[:success] = t "msg.create_cate_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "msg.create_cate_fail"
      render :index
    end
  end

  def edit
    render :index
  end

  def update
    @category.update_attributes params_cate
    if @category.save
      flash[:success] = t "msg.update_success"
    else
      flash[:danger] = t "msg.update_fail"
    end
    redirect_to admin_categories_path
  end

  def destroy
    if @category.destroy
      flash[:success] =  t "msg.delete_cate_success"
    else
      flash[:danger] = t "msg.delete_cate_fail"
    end
    redirect_to admin_categories_path
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "msg.category_invalid"
    redirect_to root_admin_path
  end

  def params_cate
    params.require(:category).permit :name
  end

  def build_category
    @category = Category.new
  end

  def all_categories
    @categories = Category.newest.paginate page: params[:page],
       per_page: Settings.paginate.categories
  end

  def stt
    params[:page] = 1 unless params[:page]
    @stt = Settings.paginate.categories * (params[:page].to_i - 1)
  end
end
