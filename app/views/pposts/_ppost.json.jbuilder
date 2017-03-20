json.extract! ppost, :id, :title, :body, :created_at, :updated_at
json.url ppost_url(ppost, format: :json)
