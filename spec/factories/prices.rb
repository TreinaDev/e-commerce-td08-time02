FactoryBot.define do
  factory :price do
    association :admin
    association :product
    value { 9.99 }
    start_date { Time.zone.today }
    end_date { 1.week.from_now }
  end
end
