FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@mercadores.com.br" }
    password { 'password' }
    name { 'João' }
    status { :approved }
  end
end
