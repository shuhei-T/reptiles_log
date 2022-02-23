class LogsController < ApplicationController
  # before_action :set_reptile_id

  def index
    page = params[:page] || 1
    @reptile = current_user.reptiles.find(params[:reptile_id])
    @logs = @reptile.logs.includes(:reptile).includes(:user).includes(:log_feeds).all.order(created_at: :desc).page(page).per(15)
    @logs_by_date = @logs.group_by{|log|log.created_at.to_date}
  end

  def new
    @reptile = current_user.reptiles.find(params[:reptile_id])
    @log = @reptile.logs.new
    @log.log_feeds.build
    # @feeds = Feed.all
  end

  def create
    @log = current_user.logs.build(log_params)
    if @log.save!
      redirect_to reptile_logs_path, success: "#{l @log.created_at, format: :long} に記録しました"
    end
  end

  def show
    @reptile = current_user.reptiles.find(params[:reptile_id])
    @log = @reptile.logs.find(params[:id])
  end

  def edit
    @reptile = current_user.reptiles.find(params[:reptile_id])
    @log = current_user.logs.find(params[:id])
    @feeds = Feed.all
  end
  
  def update
    @log = current_user.logs.find(params[:id])
    if @log.update!(log_params)
      redirect_to reptile_logs_path, success: "#{l @log.created_at, format: :long} の記録を更新しました"
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

  def set_log_id
    
  end

  def log_params
    params.require(:log).permit(:remark, :condition, :shit, :bath, :handling, :creaning, :creaning, :sheding, :weight, :length, { images: [] }, {images_cache: [] }, :temperature, :humidity,
    log_feeds_attributes:[:id, :count, :feed_id]).merge(reptile_id: params[:reptile_id])
  end
end
