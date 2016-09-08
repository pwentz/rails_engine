json.array! @items do |item|
  json.extract! item, :id,
                      :description,
                      :created_at,
                      :updated_at,
                      :merchant_id,
                      :name
  json.unit_price formatted_price(item)
end
