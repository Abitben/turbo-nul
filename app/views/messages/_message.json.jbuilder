json.extract! message, :id, :object, :body, :created_at, :updated_at
json.url message_url(message, format: :json)