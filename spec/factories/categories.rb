FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Eletrônicos#{n}" }
    association :admin
    status { :active }

    factory :subcategory do
      name { 'Celular' }
      association :category, factory: :category
      admin { category.admin }
    end
  end
end
