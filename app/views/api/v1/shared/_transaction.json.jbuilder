json.extract! transaction, :id,
                           :invoice_id,
                           :result,
                           :created_at,
                           :updated_at
json.credit_card_number formatted_cc_number(transaction)
