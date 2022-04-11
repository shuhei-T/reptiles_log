class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy own_list]

  def index
    @search  = User.ransack(params[:q])
    @users = @search.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def own_list
    @reptiles = @user.reptiles.order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: t('defaults.message.updated', item: User.model_name)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: t('defaults.message.deleted', item: User.model_name.human)
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :avatar, :avatar_cache, :role)
  end
end
