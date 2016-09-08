json.array! @transactions do |transaction|
  json.extract! transaction, :id,
                             :invoice_id,
                             :created_at,
                             :result,
                             :updated_at
  json.credit_card_number formatted_cc_number(transaction)
end
