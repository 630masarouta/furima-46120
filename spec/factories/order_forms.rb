FactoryBot.define do
  factory :order_form do
    association :user
    association :item

    postal_code   { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building      { 'テストビル 101' }
    phone_number  { Faker::Number.leading_zero_number(digits: 11) }
    token         { "tok_#{Faker::Alphanumeric.alphanumeric(number: 28)}" }
  end
end