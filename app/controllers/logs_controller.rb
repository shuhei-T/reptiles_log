class LogsController < ApplicationController
  before_action :set_reptile_id, only: %i[index new create]

  def index
    page = params[:page] || 1
    @logs = @reptile.logs.includes(:reptile).includes(:user).includes(:log_feeds).all.order(created_at: :desc).page(page).per(15)
    @logs_by_date = @logs.group_by{|log|log.created_at.to_date}
  end

  def new
    @log = @reptile.logs.new
    @log.log_feeds.build
  end

  def create
    # binding.pry
    @log = current_user.logs.build(log_params)
    if @log.save
      redirect_to reptile_logs_path, success: "#{l @log.created_at, format: :long} に記録しました"
    else
      render :new
    end
  end

  def destroy
    @log = current_user.logs.find(params[:id])
    if @log.destroy!
      redirect_to reptile_logs_path, success: "#{l @log.created_at, format: :long}の記録を削除しました"
    end
  end

  private

  def set_reptile_id
    @reptile = current_user.reptiles.find(params[:reptile_id])
  end

  def log_params
    params.require(:log).permit(:remark, :condition, :shit, :bath, :handling, :creaning, :creaning, :sheding, :weight, :length, { images: [] }, {images_cache: [] }, :temperature, :humidity,
    log_feeds_attributes:[:id, :count, :size, :feed_id, :_destroy]).merge(reptile_id: params[:reptile_id])
  end
end
