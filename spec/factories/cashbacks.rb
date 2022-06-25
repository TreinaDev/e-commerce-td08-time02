FactoryBot.define do
  factory :cashback do
    start_date { 1.day.from_now }
    end_date { 1.week.from_now }
    percentual { 10 }

    association :admin
  end
end
