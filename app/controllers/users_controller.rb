class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to reptiles_path, success: t('.success')
    else
      redirect_to new_user_path, danger: t('.fail')
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def search;end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
