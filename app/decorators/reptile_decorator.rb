class ReptileDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def full_age
    if birthday
      calced_age = calc_age(birthday)
      if calced_age > 0
        "#{calced_age} 歳"
      else
        "#{calc_month(birthday)} ヶ月"
      end
    elsif adoptaversary && calced_age
      "#{calc_age(adoptaversary) + calced_age} 歳"
    elsif age
      "#{age} 歳"
    end
  end

  def full_adoptaversary
    year, month = calc_month(adoptaversary).divmod(12)
    if year > 0 && month != 0
      "#{year} 年 #{month} ヶ月"
    elsif year <= 0
      "#{month} ヶ月"
    elsif month <= 0
      "#{year} 年"
    end
  end


  private

  def calc_age(birthdayStr)
    return (Date.today.strftime("%Y%m%d").to_i - birthdayStr.strftime("%Y%m%d").to_i) / 10000
  end

  def calc_month(birthdayStr)
    return ((Date.today - birthdayStr).to_i / 30).floor
  end

end
