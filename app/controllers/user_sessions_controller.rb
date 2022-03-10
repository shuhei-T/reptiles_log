class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]
  before_action :forbid_login_user, only: %i[new create]

  def new;end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to reptiles_path, success: t('.success')
    else
      redirect_to new_user_path, danger: t('.fail')
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  def guest_login
    @guest_user = User.guest
    auto_login(@guest_user)
    redirect_to reptiles_path, success: t('.success')
  end
end