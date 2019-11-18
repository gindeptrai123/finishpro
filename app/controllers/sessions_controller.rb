class SessionsController < ApplicationController
  layout "users_sessions"
  before_action :load_user, only: :create

  def new
    return unless logged_in?
    redirect_to root_path
  end

  def create
    log_in @user
    redirect_to root_path
  end

  def delete
    log_out
    redirect_to root_path
  end

  private

  def load_user
    @user = User.find_by user_name: params[:session][:user_name]
    return if @user && @user.authenticate(params[:session][:password])
    flash.now[:danger] = t "msg.username_pass_invalid"
    render :new
  end
end
