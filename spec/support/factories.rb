FactoryGirl.define do
  factory :customer do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end

  factory :merchant do
    name Faker::Company.name
  end

  factory :invoice do
    customer
    merchant
    status 'shipped'
  end

  factory :transaction do
    invoice
    credit_card_number 424_242_424_242_424_2
    result 'success'

    factory :failed_transaction do
      result 'failed'
    end
  end

  factory :invoice_item do
    invoice
    item
    quantity Faker::Number.number(1)
    unit_price Faker::Number.number(5)
  end

  factory :item do
    name Faker::Commerce.product_name
    description Faker::Lorem.sentence
    unit_price Faker::Number.number(5)
    merchant
  end
end
