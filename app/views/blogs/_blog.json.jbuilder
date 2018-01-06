json.extract! blog, :id, :name, :description, :content, :created_at, :updated_at
json.url blog_url(blog, format: :json)
