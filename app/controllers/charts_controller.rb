class ChartsController < ApplicationController

  def index
    @reptile = current_user.reptiles.find(params[:reptile_id])
    @charts = @reptile.logs.all.order(created_at: :asc)

    this_month = Date.today.all_month



    # 日付
    day = []
    @charts.each do |chart|
      day << chart.created_at.strftime("%Y年%m月%d日 %H:%M").to_s
    end
    gon.day = day

    # 今月
    month = []
    @charts.each do |chart|
      if (this_month.include?(Date.parse(chart[:created_at].to_s)))
        month << chart.created_at.strftime("%Y年%m月%d日 %H:%M").to_s
      end
    end
    # => ["2022年03月01日 02:58", "2022年03月01日 12:35", "2022年03月01日 13:16", "2022年03月01日 13:19", "2022年03月01日 13:22", "2022
    #   03月01日 16:09"]

    # year = []
    # @charts.each do |chart|
    #   year << chart.created_at.strftime('')
    # end

    # 体重
    gon.weight = @reptile.logs.pluck(:weight)

    # 体長
    gon.length = @reptile.logs.pluck(:length)

    # 温度
    gon.temperature = @reptile.logs.pluck(:temperature)

    # 湿度
    gon.humidity = @reptile.logs.pluck(:humidity)

  end
end
