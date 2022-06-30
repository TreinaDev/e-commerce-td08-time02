FactoryBot.define do
  factory :review do
    rating { 5 }
    comment { "Gostei muito! Recomendo!" }
    association :client
    association :product
  end
end
