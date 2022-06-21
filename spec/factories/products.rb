FactoryBot.define do
  factory :product do
    name { 'TV 45' }
    brand { 'LG' }
    description { 'TV 4k de 45 polegadas' }
    width { '99.99' }
    height { '20.99' }
    depth { '5.99' }
    weight { '9.99' }
    shipping_price { '90.99' }
    status { :active }
    sequence(:sku) { |number| "TLT4#{number}-NCK9832" }
    association :category

    after(:build) do |product|
      product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                            filename: 'placeholder-image-1.png', content_type: 'image/png')
    end
  end
end
