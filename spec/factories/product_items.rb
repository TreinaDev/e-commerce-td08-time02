FactoryBot.define do
  factory :product_item do
    quantity { 1 }
    product
    client
  end
end
