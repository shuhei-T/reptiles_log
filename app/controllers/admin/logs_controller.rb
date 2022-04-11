class Admin::LogsController < Admin::BaseController
  before_action :set_reptile_id, only: %i[index]

  def index
    page = params[:page] || 1
    @logs = @reptile.logs.includes(:log_feeds).all.order(logged_at: :desc).page(page).per(15)
    @logs_by_date = @logs.group_by{|log|log.logged_at.to_date}
  end

  def destroy
    @log = Log.find(params[:id])
    if @log.destroy!
      redirect_to admin_reptile_logs_path, success: "#{l @log.logged_at, format: :long}の記録を削除しました"
    end
  end

  private

  def set_reptile_id
    @reptile = Reptile.find(params[:reptile_id])
  end

  def log_params
    params.require(:log).permit(:remark, :condition, :shit, :bath, :handling, :creaning, :sheding, :weight, :length, :logged_at, { images: [] }, :images_cache, :temperature, :humidity, log_feeds_attributes:[:id, :count, :size, :feed_id, :_destroy]).merge(reptile_id: params[:reptile_id])
  end
end
