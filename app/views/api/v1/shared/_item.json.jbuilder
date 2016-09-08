json.extract! item, :id,
                    :name,
                    :description,
                    :merchant_id,
                    :created_at,
                    :updated_at
json.unit_price formatted_price(item)
