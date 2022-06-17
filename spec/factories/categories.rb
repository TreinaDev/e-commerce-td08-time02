FactoryBot.define do
  factory :category do
    name { 'Eletronicos' }
    association :admin
  end

  factory :subcategory do
    name { 'Celular' }
    association :category, factory: :category
    association :admin
  end
end
