json.extract! menu, :id, :name, :intro, :price, :store_id, :created_at, :updated_at
json.url menu_url(menu, format: :json)
