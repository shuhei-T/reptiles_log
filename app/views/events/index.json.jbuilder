json.array!(@events) do |event|
  json.extract! event, :id, :remark, :condition, :creaning, :handling, :humidity, :images, :length, :remark, :reptile_id, :sheding, :shit, :temperature, :weight
  json.title event.logged_at.strftime("%H:%M")
  json.start event.logged_at
  json.end event.logged_at
  json.allDay true
end