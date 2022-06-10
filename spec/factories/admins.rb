FactoryBot.define do
  factory :admin do
    email { 'admin@mercadores.com.br' }
    password { 'password' }
    name { 'João' }
    status { :approved }
  end
end
