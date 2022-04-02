class ChartsController < ApplicationController
  before_action :set_reptile_id, only: %i[index]

  def index
    # 体重
    @weight = @reptile.logs.pluck(:weight).compact.to_json.html_safe
    @weight_charts = @reptile.logs.where("weight IS NOT NULL").order(logged_at: :asc)
    weight_day = Array.new
    @weight_charts.each do |chart|
      weight_day << chart.logged_at.strftime("%Y-%m-%d %H:%M").to_s
    end
    @weight_day = weight_day.to_json.html_safe

    # 体長
    @length = @reptile.logs.pluck(:length).compact.to_json.html_safe
    @length_charts = @reptile.logs.where("length IS NOT NULL").order(logged_at: :asc)
    length_day = Array.new
    @length_charts.each do |chart|
      length_day << chart.logged_at.strftime("%Y-%m-%d %H:%M").to_s
    end
    @length_day = length_day.to_json.html_safe

    # 温度
    @temperature = @reptile.logs.pluck(:temperature).compact.to_json.html_safe
    @temperature_charts = @reptile.logs.where("temperature IS NOT NULL").order(logged_at: :asc)
    temperature_day = Array.new
    @temperature_charts.each do |chart|
      temperature_day << chart.logged_at.strftime("%Y-%m-%d %H:%M").to_s
    end
    @temperature_day = temperature_day.to_json.html_safe

    # 湿度
    @humidity = @reptile.logs.pluck(:humidity).compact.to_json.html_safe
    @humidity_charts = @reptile.logs.where("humidity IS NOT NULL").order(logged_at: :asc)
    humidity_day = Array.new
    @humidity_charts.each do |chart|
      humidity_day << chart.logged_at.strftime("%Y-%m-%d %H:%M").to_s
    end
    @humidity_day = humidity_day.to_json.html_safe
  end

  private

  def set_reptile_id
    @reptile = current_user.reptiles.find(params[:reptile_id])
  end
end
