FactoryBot.define do
  factory :purchase_record_shipping_address do
    post_code         { "123-4567" }
    prefectures_id    { Faker::Number.between(from: 2, to: 48) } # 1は除外（'---'）
    municipalities    { Faker::Address.city }
    street_address    { Faker::Address.street_address }
    building_name     { Faker::Address.secondary_address }
    telephone_number  { "09012345678" }
    token             { 'tok_' + Faker::Lorem.characters(number: 28) }
    user_id           { Faker::Number.non_zero_digit }
    item_id           { Faker::Number.non_zero_digit }
  end
end