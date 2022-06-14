FactoryBot.define do
  factory :price do
    admin { nil }
    product { nil }
    value { "9.99" }
    start_date { "2022-06-14" }
    end_date { "2022-06-14" }
  end
end
