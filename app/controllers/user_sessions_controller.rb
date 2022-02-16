class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :forbid_login_user, only: %i[new create]

  def new;end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to reptiles_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
