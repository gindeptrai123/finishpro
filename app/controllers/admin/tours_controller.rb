class Admin::ToursController < AdminController
  before_action :load_tour, except: %i(index new create)

  def index
    @tours = Tour.order("created_at desc")
  end

  def show; end

  def edit; end

  def new
    @tour = Tour.new
  end

  def create
    @tour = current_user.tours.build tour_params
    if @tour.save
      flash[:info] = t "msg.approved"
      render :show
    else
      render :new
    end
  end

  def update
    @tour.attributes = tour_params
    if @tour.save
      flash[:success] = t "msg.update"
      render :show
    else
      flash[:danger] = t "msg.update_err"
      render :edit
    end
  end

  def destroy
    return unless @tour.destroy
    flash[:success] = t "msg.del"
    redirect_to admin_tours_path
  end

  private

  def tour_params
    params.require(:tour).permit Tour::UPDATE_ATTRS
  end
end
