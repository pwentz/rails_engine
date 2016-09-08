json.array! @invoice_items do |invoice_item|
  json.extract! invoice_item, :id,
                              :item_id,
                              :invoice_id,
                              :quantity,
                              :created_at,
                              :updated_at
  json.unit_price formatted_price(invoice_item)
end
