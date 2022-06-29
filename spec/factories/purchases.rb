FactoryBot.define do
  factory :purchase do
    association :client
    status { :approved }
    value { 20.0 }
  end
end
