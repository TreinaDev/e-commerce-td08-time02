FactoryBot.define do
  factory :promotion do
    start_date { Time.zone.today }
    end_date { 10.days.from_now }
    name { "BlackFriday" }
    discount_percentual { 40 }
    discount_max { 100 }
    used_times { 1 }
    coupon { "ABCD1234" }
    usage_limit { 10 }
    association :admin
  end
end
