FactoryBot.define do
  factory :category do
    name { 'Eletrônicos' }
    association :admin
    status { :active }

    factory :subcategory do
      name { 'Celular' }
      association :category, factory: :category
      admin { category.admin }
    end
  end
end
