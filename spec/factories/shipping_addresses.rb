FactoryBot.define do
  factory :shipping_address do
    post_code { '123-4567' }
    prefectures_id { Faker::Number.between(from: 1, to: 47) }
    municipalities { Faker::Address.city }
    street_address { Faker::Address.street_address }
    telephone_number { '09012345678' }
  end
end
