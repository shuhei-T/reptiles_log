class ChartsController < ApplicationController

  def index
    @reptile = current_user.reptiles.find(params[:reptile_id])
    @charts = @reptile.logs.includes(:reptile).includes(:user).includes(:log_feeds).all.order(created_at: :asc)

    # 日付
    day = []
    @charts.each do |chart|
      day << chart.created_at.strftime('%Y%m%d').to_s
    end
    @charts_by_day = day.each_with_object(Hash.new(0)){ |value, hash| hash[value] += 1 }
    @chartlabels = @charts_by_day.map(&:first).to_json.html_safe

    # 体重
    weight = []
    @charts.each do |chart|
      weight << chart.weight
    end
    @weight_by_day = weight.each_with_object(Hash.new(0)){ |value, hash| hash[value] += 1 }
    @weightdata = @weight_by_day.map(&:first).to_json.html_safe
    # binding.pry
    # 体長
    length = []
    @charts.each do |chart|
      length << chart.length
    end
    @length_by_day = length.each_with_object(Hash.new(0)){ |value, hash| hash[value] += 1 }
    @lengthdata = @length_by_day.map(&:first).to_json.html_safe

    # 温度
    temperature = []
    @charts.each do |chart|
      temperature << chart.temperature
    end
    @temperature_by_day = temperature.each_with_object(Hash.new(0)){ |value, hash| hash[value] += 1 }
    @temperature_data = @temperature_by_day.map(&:first).to_json.html_safe

    # 湿度
    humidity = []
    @charts.each do |chart|
      humidity << chart.humidity
    end
    @humidity_by_day = humidity.each_with_object(Hash.new(0)){ |value, hash| hash[value] += 1 }
    @humidity_data = @humidity_by_day.map(&:first).to_json.html_safe
  end
end
