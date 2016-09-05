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
  end
end
