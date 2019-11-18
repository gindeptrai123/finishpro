class UsersController < ApplicationController
  layout "users_sessions"
  before_action :load_user, except: %i(new create)
  before_action :logged_in_user, :correct_user, only: %i(update edit)

  def show; end

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "msg.create_user_success"
      redirect_to edit_user_path
    else
      flash[:danger] = t "msg.create_user_fail"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "msg.user_invalid"
    redirect_to root_path
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end
end
