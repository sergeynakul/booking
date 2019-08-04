json.extract! reservation, :id, :start, :duration, :user, :table_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
