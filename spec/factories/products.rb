FactoryBot.define do
  factory :product do
    name { "MyString" }
    brand { "MyString" }
    description { "MyString" }
    sku { "MyString" }
    width { "9.99" }
    height { "9.99" }
    depth { "9.99" }
    weight { "9.99" }
    shipping_price { "9.99" }
    fragile { false }
    status { 1 }
  end
end
