FactoryBot.define do
  factory :product do
    name { "TV 45" }
    brand { "LG" }
    description { "TV 4k de 45 polegadas " }
    sku { "TLT45-NCK9832" }
    width { "99.99" }
    height { "20.99" }
    depth { "5.99" }
    weight { "9.99" }
    shipping_price { "90.99" }
    fragile { false }
    status { 0 }
  end
end
