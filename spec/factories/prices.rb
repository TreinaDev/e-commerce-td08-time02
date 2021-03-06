FactoryBot.define do
  factory :price do
    association :product
    admin { product.category.admin }
    value { 9.99 }
    start_date { Time.zone.today }
    end_date { 90.days.from_now }
  end
end
