json.extract! @item, :id,
                     :description,
                     :created_at,
                     :name,
                     :updated_at,
                     :merchant_id
json.unit_price formatted_price(@item)
