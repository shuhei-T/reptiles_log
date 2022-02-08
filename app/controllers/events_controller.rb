class EventsController < ApplicationController

  def index
    @reptile = current_user.reptiles.find(params[:reptile_id])
    @events = @reptile.logs.includes(:reptile).includes(:user).includes(:log_feeds).all.order(created_at: :desc)
  end
  
  def new
    @reptile = current_user.reptiles.find(params[:reptile_id])
    @event = @reptile.logs.new
    @event.log_feeds.build
    @feeds = Feed.all
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { event: @event })
  end

  def create
    @event = current_user.logs.build(log_params)
    if @event.save!
      respond_to do |format|
      format.html { redirect_to reptile_events_path, success: "#{l @event.created_at, format: :long} に記録しました" }
      format.js # create.js.erbを探してその中を実行
      end
    end
  end

  def show
    @reptile = current_user.reptiles.find(params[:reptile_id])
    @event = @reptile.logs.find(params[:id])
    render plain: render_to_string(partial: 'show_modal', layout: false, locals: { event: @event })
  end

  def destroy
    @event = current_user.logs.find(params[:id])
    if @event.destroy!
      redirect_to reptile_events_path, success: "#{l @event.created_at, format: :long}の記録を削除しました"
    end
  end

  private

  def log_params
    params.require(:log).permit(:remark, :condition, :shit, :bath, :handling, :creaning, :creaning, :sheding, :weight, :length, { images: [] }, {images_cache: [] }, :temperature, :humidity,
    log_feeds_attributes:[:id, :count, :feed_id]).merge(reptile_id: params[:reptile_id])
  end
end