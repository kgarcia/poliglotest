json.extract! event, :id, :start_time, :recurring, :number, :course_id, :created_at, :updated_at
json.url event_url(event, format: :json)
