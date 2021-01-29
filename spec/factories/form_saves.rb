FactoryBot.define do
  factory :form_save do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building { Faker::Address.building_number }
    phone_number { Faker::Number.leading_zero_number(digits: 10) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
