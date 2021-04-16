FactoryBot.define do
  factory :product do
    product_name { 'test' }
    description { 'test' }
    category_id { 2 }
    condition_id { 2 }
    delivery_burden_id { 2 }
    prefecture_id { 2 }
    days_to_ship_id { 2 }
    price { 1000 }

    association :user

    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
