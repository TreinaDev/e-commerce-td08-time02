FactoryBot.define do
  factory :category do
    name { 'Eletronicos' }
  end

  factory :subcategory do
    name { 'Celular'}
    association :category, factory: :category
  end
end
