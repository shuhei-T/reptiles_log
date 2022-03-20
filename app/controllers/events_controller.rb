class EventsController < ApplicationController
  before_action :set_reptile_id, only: %i[index new show create]

  def index
    @events = @reptile.logs.includes(:log_feeds).all.order(logged_at: :desc)
  end
  
  def new
    @event = @reptile.logs.new
    @event.log_feeds.build
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { event: @event })
  end

  def create
    @event = current_user.logs.build(log_params)
    if @event.save
      respond_to do |format|
      format.html { redirect_to reptile_events_path, success: "#{l @event.logged_at, format: :long} に記録しました" }
      format.js # create.js.erbを探してその中を実行
      end
    end
  end

  def show
    @event = @reptile.logs.find(params[:id])
    render plain: render_to_string(partial: 'show_modal', layout: false, locals: { event: @event })
  end

  def destroy
    @event = current_user.logs.find(params[:id])
    if @event.destroy!
      respond_to do |format|
        format.html { redirect_to reptile_events_path, success: "#{l @event.logged_at, format: :long}の記録を削除しました" }
        format.js
      end
    end
  end

  private

  def set_reptile_id
    @reptile = current_user.reptiles.find(params[:reptile_id])
  end

  def log_params
    params.require(:log).permit(:remark, :condition, :shit, :bath, :handling, :creaning, :creaning, :sheding, :weight, :length, :logged_at, { images: [] }, :images_cache, :temperature, :humidity,
    log_feeds_attributes:[:id, :count, :size, :feed_id]).merge(reptile_id: params[:reptile_id])
  end
end