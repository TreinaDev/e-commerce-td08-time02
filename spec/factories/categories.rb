FactoryBot.define do
  factory :category do
    name { 'Eletronicos' }
    admin
  end

  factory :subcategory do
    name { 'Celular' }
    association :category, factory: :category
    admin
  end
end
