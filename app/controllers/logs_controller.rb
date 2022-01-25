class LogsController < ApplicationController
  # before_action :set_reptile_id

  def index
    @reptile = current_user.reptiles.find(params[:reptile_id])
    logs = Log.includes(:reptile).includes(:user).includes(:log_feeds).all.order(created_at: :desc)
    @logs_by_date = logs.group_by{|log|log.updated_at.to_date}

    # @date = Log.all.select(:created_at).distinct.order(:created_at)
    # @date = Log.all.select(:created_at).group_by{|list|list.created_at.to_date}
    # @date = Log.where(created_at: search_date.in_time_zone.all_day)
  end

  def new
    # @log_feeds = @reptile.log_feeds
    # @content = @pet.contents.find_or_initialize_by(have_on: Date.today)
    @reptile = current_user.reptiles.find(params[:reptile_id])
    @log = @reptile.logs.new
    @log.log_feeds.build
    @feeds = Feed.all

  end

  def create
    # @log = @reptile.logs.new(log_params)
    @log = current_user.logs.build(log_params)
    # binding.pry
    if @log.save!
      redirect_to reptile_logs_path, success: "#{l @log.created_at, format: :long} に記録しました"
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    @log = Log.find(params[:id])
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
    params.require(:log).permit(:remark, :condition, :shit, :bath, :handling, :creaning, :creaning, :sheding, :weight, :length, :image, :image_cache, :temperature, :humidity,
    log_feeds_attributes:[:id, :count, :feed_id]).merge(reptile_id: params[:reptile_id])
  end
end
