FactoryBot.define do
  factory :client do
    email { 'cliente@email.com' }
    password { 'password' }
    name { 'João' }
    code { '510.309.910-14' }

    trait :another_email do
      email { 'outroemail@email.com' }
    end

    trait :another_code do
      email { '122.333.977-00' }
    end

    trait :code_is_cnpj do
      code { '82.425.181/0001-62' }
    end
  end
end
