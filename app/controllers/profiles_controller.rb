class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update following followers withdrawal destroy]

  def show;end

  def edit;end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.updated', item: User.model_name.human)
      render :edit
    end
  end

  def following
    @title = "フォロー中"
    @users = @user.following
    @count =@users.count
    render 'show_follow'
  end
  
  def followers
    @title = "フォロワー"
    @users = @user.followers
    @count =@users.count
    render 'show_follow'
  end

  def withdrawal;end

  def destroy
    @user.destroy
    redirect_to root_path, success: t('.success')
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :avatar_cache, :comment)
  end

end
