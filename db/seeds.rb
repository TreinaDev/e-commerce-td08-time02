# Admins
admin = Admin.create!(email: 'arthur@mercadores.com.br', password: 'password', name: 'Arthur', status: :approved)
Admin.create!(email: 'marco@mercadores.com.br', password: 'password', name: 'Marco')

# Clientes
Client.create!(email: 'marquinhos@hotmail.com', password: 'password', name: 'Marquinhos', code: '61.887.261/0001-60')
Client.create!(email: 'juliana@hotmail.com', password: 'password', name: 'Juliana', code: '622.894.020-10')
Client.create!(email: 'jadson@hotmail.com', password: 'password', name: 'Jadson', code: '59641220004')

# Categorias
first_category = Category.create!(name: 'Eletronicos', admin:, status: :active)
second_category = Category.create!(name: 'Roupas', admin:, status: :active)
third_category = Category.create!(name: 'Celulares', admin:, category: first_category, status: :active)
fourth_category = Category.create!(name: 'Camisetas', admin:, category: second_category, status: :active)
Category.create!(name: 'Jardinagem', admin:, status: :disabled)

# Taxa de conversão
ExchangeRate.create!(value: 2.0)

# Cashbacks
first_cashback = Cashback.create!(start_date: Time.zone.today, end_date: 1.week.from_now, percentual: 20, admin:)
second_cashback = Cashback.create!(start_date: Time.zone.today, end_date: 1.week.from_now, percentual: 10, admin:)
Cashback.create!(start_date: 1.month.from_now, end_date: 2.months.from_now, percentual: 5, admin:)

# Produtos
first_product = Product.create!(name: 'Monitor 8k', brand: 'LG', category: first_category,
                                description: 'Monitor de alta qualidade', sku: 'MON8K-64792', height: 50,
                                width: 100, depth: 12, weight: 12, shipping_price: 23, fragile: true,
                                status: :active, cashback: first_cashback)
first_product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                            filename: 'placeholder-image-1.png', content_type: 'image/png')
first_product.manual.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-manual.pdf')),
                            filename: 'placeholder-manual.pdf', content_type: 'application/pdf')
Price.create!(admin: admin, product: first_product, start_date: Time.zone.today, end_date: 90.days.from_now,
              value: 1500.00)

second_product = Product.create!(name: 'Casaco da Razer', brand: 'Razer', category: second_category,
                                 description: 'Casaco de Lã de Ovelha', sku: 'CAS8KU-99999', height: 50,
                                 width: 120, depth: 7, weight: 1.5, shipping_price: 50, fragile: false,
                                 status: :active, cashback: second_cashback)
second_product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-2.png')),
                             filename: 'placeholder-image-2.png', content_type: 'image/png')
Price.create!(admin: admin, product: second_product, start_date: Time.zone.today, end_date: 45.days.from_now,
              value: 200.00)
Price.create!(admin: admin, product: second_product, start_date: 46.days.from_now, end_date: 90.days.from_now,
              value: 150.00)

third_product = Product.create!(name: 'Apple 13', brand: 'Apple', category: third_category,
                                description: 'Apple 13 256gb Verde', sku: 'APP8KU-99999', height: 16, width: 9,
                                depth: 2, weight: 0.8, shipping_price: 30, fragile: true, status: :active)
third_product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-2.png')),
                            filename: 'placeholder-image-2.png', content_type: 'image/png')
Price.create!(admin: admin, product: third_product, start_date: Time.zone.today, end_date: 180.days.from_now,
              value: 2000.00)

fourth_product = Product.create!(name: 'Camiseta do Flamengo', brand: 'Flamengo', category: fourth_category,
                                 description: 'Camisa Mengão 2022', sku: 'MENP8KU-99999', height: 55, width: 120,
                                 depth: 8, weight: 0.5, shipping_price: 30, fragile: false, status: :inactive)
fourth_product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-2.png')),
                             filename: 'placeholder-image-2.png', content_type: 'image/png')
Price.create!(admin: admin, product: fourth_product, start_date: Time.zone.today, end_date: 60.days.from_now,
              value: 140.00)

fifth_product = Product.create!(name: 'Capa de Celular HyperX', brand: 'HyperZ', category: third_category,
                                 description: 'Capa em couro sintético gamer', sku: 'CAPP8KU-99119', height: 14, width: 8,
                                 depth: 2, weight: 0.1, shipping_price: 25, fragile: false, status: :active)
fifth_product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-2.png')),
                        filename: 'placeholder-image-2.png', content_type: 'image/png')

Price.create!(admin: admin, product: fifth_product, start_date: Time.zone.today, end_date: 180.days.from_now,
value: 140.00)

#Promoções
first_promotion = Promotion.create!(name: 'BlackFriday', discount_percentual: 50, discount_max: 200, usage_limit: 100,
                                    start_date: 1.day.from_now, end_date: 1.month.from_now, admin:)

second_promotion = Promotion.create!(name: 'Dia das Mães', discount_percentual: 30, discount_max: 100, usage_limit: 50,
                                    start_date: 1.day.from_now, end_date: 1.week.from_now, admin:)

third_promotion = Promotion.create!(name: 'Dia dos Namorados', discount_percentual: 20, discount_max: 60, usage_limit: 40,
                                    start_date: 1.day.from_now, end_date: 1.week.from_now, admin:)
