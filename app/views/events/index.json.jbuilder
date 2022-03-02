json.array!(@events) do |event|
  json.extract! event, :id, :remark, :condition, :creaning, :handling, :humidity, :images, :length, :remark, :reptile_id, :sheding, :shit, :temperature, :weight
  json.title event.created_at.strftime("%H:%M")
  json.start event.created_at
  json.end event.created_at
  json.allDay true
end