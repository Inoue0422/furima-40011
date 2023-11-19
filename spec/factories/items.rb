FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    category_id { 2 }
    condition_id { 2 }
    delivery_charge_id { 2 }
    region_id { 2 }
    delivery_day_id { 2 }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/sample_image.jpeg'), filename: 'sample_image.jpeg',
                        content_type: 'image/jpeg')
    end
  end
end
