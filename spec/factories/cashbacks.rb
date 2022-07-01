FactoryBot.define do
  factory :cashback do
    start_date { Time.zone.today }
    end_date { 1.week.from_now }
    percentual { 10 }

    association :admin
  end
end
