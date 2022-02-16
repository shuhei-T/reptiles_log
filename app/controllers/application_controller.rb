class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login, :set_search

  private

  def not_authenticated
    redirect_to login_path, warning: t('defaults.message.require_login')
  end

  def set_search
    @q = User.ransack(params[:q])
    @search_users = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def forbid_login_user
    if current_user
      redirect_to reptiles_path, warning: t('defaults.message.forbid_login_user')
    end
  end

end
