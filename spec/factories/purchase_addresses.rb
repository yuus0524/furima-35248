FactoryBot.define do
  factory :purchase_address do
      post_code { "123-4567" }
      prefecture_id { 2 }
      city {Gimei.city.kanji}
      block {"#{Gimei.town.kanji}1-1"}
      building { "sampleハイツ" }
      phone_number { "09012345678" }
  end
end
