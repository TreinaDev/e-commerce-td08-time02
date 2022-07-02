# Admins
admin = Admin.create!(email: 'arthur@mercadores.com.br', password: 'password', name: 'Arthur', status: :approved)
Admin.create!(email: 'marco@mercadores.com.br', password: 'password', name: 'Marco')

# Taxa de conversão
ExchangeRate.create!(value: 2.0)

# Clientes
    # Clientes sem saldo
    no_balance_client = Client.create!(email: 'joaquina@hotmail.com', password: 'password', name: 'Joaquina Marques', code: '918.193.130-18')
    # Clientes com saldo
    first_client = Client.create!(email: 'marquinhos@hotmail.com', password: 'password', name: 'Marquinhos', code: '61.887.261/0001-60')
    second_client = Client.create!(email: 'juliana@hotmail.com', password: 'password', name: 'Juliana', code: '622.894.020-10')
    #Clientes sem compras
    no_purchase_client = Client.create!(email: 'jadson@hotmail.com', password: 'password', name: 'Jadson', code: '596.412.200-04')

# Categorias
    # Categorias pai
    first_category = Category.create!(name: 'Eletrônicos', admin:, status: :active)
    second_category = Category.create!(name: 'Roupas', admin:, status: :active)
    # Categorias filhas
    third_category = Category.create!(name: 'Celulares', admin:, category: first_category, status: :active)
    fourth_category = Category.create!(name: 'Camisetas', admin:, category: second_category, status: :active)
    seventh_category = Category.create!(name: 'Computadores', admin:, category: first_category, status: :active)
    # Categorias ativas e sem produtos
    fifth_category = Category.create!(name: 'Bebidas', admin:, status: :active)
    # Categorias desativadas e com produtos
    sixth_category = Category.create!(name: 'Jardinagem', admin:, status: :disabled)


# Cashbacks
first_cashback = Cashback.create!(start_date: Time.zone.today, end_date: 1.week.from_now, percentual: 20, admin:)
second_cashback = Cashback.create!(start_date: Time.zone.today, end_date: 1.week.from_now, percentual: 10, admin:)
Cashback.create!(start_date: 1.month.from_now, end_date: 2.months.from_now, percentual: 5, admin:)

# Produtos
product_1 = Product.create!(name: 'Tablet SAMSUNG 5G', brand: 'SAMSUNG', category: third_category,
                                description: 'Tablet para crianças', sku: 'TABLE-64792', height: 12,
                                width: 15, depth: 2, weight: 12, shipping_price: 20, fragile: true,
                                status: :active)
product_1.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-2.png')),
                            filename: 'placeholder-image-1.png', content_type: 'image/png')
Price.create!(admin: admin, product: product_1, start_date: Time.zone.today, end_date: 90.days.from_now,
value: 2000.00)
                            
product_2 = Product.create!(name: 'Camiseta do Homem Aranha', brand: 'Marvel', category: fourth_category,
                            description: 'Com grandes poderes, vêm grandes responsabilidades', 
                            sku: 'CAMIHO-64792', height: 50, width: 120, depth: 2, weight: 1, 
                            shipping_price: 15, fragile: false, status: :active)
product_2.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                        filename: 'placeholder-image-1.png', content_type: 'image/png')
Price.create!(admin: admin, product: product_2, start_date: Time.zone.today, end_date: 90.days.from_now,
                        value: 12200.00)

product_3 = Product.create!(name: 'Camiseta da Hermione', brand: 'WIZARDS', category: fourth_category,
                            description: 'Camiseta da Hermione sem o Rony', 
                            sku: 'AVARA-64792', height: 50, width: 90, depth: 2, weight: 1, 
                            shipping_price: 15, fragile: false, status: :active)
product_3.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                        filename: 'placeholder-image-1.png', content_type: 'image/png')
Price.create!(admin: admin, product: product_3, start_date: Time.zone.today, end_date: 90.days.from_now,
                        value: 12500.00)

product_4 = Product.create!(name: 'Computador Quântico', brand: 'IBM', category: seventh_category,
                            description: 'Capaz de desvendar qualquer criptografia', 
                            sku: 'COACHQUANTICO-64792', height: 50, width: 30, depth: 15, weight: 8, 
                            shipping_price: 200, fragile: true, status: :active)
product_4.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                        filename: 'placeholder-image-1.png', content_type: 'image/png')
Price.create!(admin: admin, product: product_4, start_date: Time.zone.today, end_date: 90.days.from_now,
                        value: 1300.00)

product_5 = Product.create!(name: 'Regador de Plástico', brand: 'EMBRAPA', category: sixth_category,
                        description: 'Regador mágico do pé de feijão', 
                        sku: 'REGMAG-64792', height: 25, width: 15, depth: 15, weight: 1, 
                        shipping_price: 23, fragile: true, status: :active)
product_5.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-2.png')),
                    filename: 'placeholder-image-1.png', content_type: 'image/png')
Price.create!(admin: admin, product: product_5, start_date: Time.zone.today, end_date: 90.days.from_now,
                    value: 100.00)

    #Produtos com Preço por mais de 90 dias
    first_product = Product.create!(name: 'Monitor 8k', brand: 'LG', category: first_category,
                                    description: 'Monitor de alta qualidade', sku: 'MON8K-64792', height: 50,
                                    width: 100, depth: 12, weight: 12, shipping_price: 23, fragile: true,
                                    status: :active, cashback: first_cashback)
    first_product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                                filename: 'placeholder-image-1.png', content_type: 'image/png')
    first_product.manual.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-manual.pdf')),
                                filename: 'placeholder-manual.pdf', content_type: 'application/pdf')
    first_product_expired_price = Price.new(admin: admin, product: first_product, start_date: 1.week.ago, end_date: 1.day.ago,
                              value: 1200.00).save(validate: false)
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

    #Produtos com Preço por mais de 90 dias e desativados
    inactive_product = Product.create!(name: 'Teclado Mecânico', brand: 'Logitech', category: first_category,
                                    description: 'Teclado do Seninha', sku: 'TECLK-64792', height: 50,
                                    width: 50, depth: 5, weight: 3, shipping_price: 44, fragile: true,
                                    status: :inactive)
    inactive_product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                                   filename: 'placeholder-image-1.png', content_type: 'image/png')
    inactive_product.manual.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-manual.pdf')),
                                   filename: 'placeholder-manual.pdf', content_type: 'application/pdf')
    Price.create!(admin: admin, product: inactive_product, start_date: Time.zone.today, end_date: 90.days.from_now,
                value: 900.00)

    #Produtos com preço por menos de 90 dias ou sem preço
    fourth_product = Product.create!(name: 'Camiseta do Flamengo', brand: 'Flamengo', category: fourth_category,
                                    description: 'Camisa Mengão 2022', sku: 'MENP8KU-99999', height: 55, width: 120,
                                    depth: 8, weight: 0.5, shipping_price: 30, fragile: false)
    fourth_product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-2.png')),
                                filename: 'placeholder-image-2.png', content_type: 'image/png')
    Price.create!(admin: admin, product: fourth_product, start_date: Time.zone.today, end_date: 60.days.from_now,
                value: 140.00)

    fifth_product = Product.create!(name: 'Capa de Celular HyperX', brand: 'HyperZ', category: third_category,
                                    description: 'Capa em couro sintético gamer', sku: 'CAPP8KU-99119', height: 14, width: 8,
                                    depth: 2, weight: 0.1, shipping_price: 25, fragile: false)
    fifth_product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-2.png')),
                            filename: 'placeholder-image-2.png', content_type: 'image/png')

    Price.create!(admin: admin, product: fifth_product, start_date: Time.zone.today, end_date: 30.days.from_now,
    value: 140.00)

    no_price_product = Product.create!(name: 'Mouse da Razer', brand: 'Razer', category: first_category,
                                    description: 'Mouse 1000000 DPI', sku: 'MOURZ-64792', height: 8,
                                    width: 6, depth: 4, weight: 1, shipping_price: 22, fragile: true)
    no_price_product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                                filename: 'placeholder-image-1.png', content_type: 'image/png')

# Promoções
Promotion.create!(name: 'BlackFriday', discount_percentual: 50, discount_max: 200, usage_limit: 100,
                                    start_date: 1.day.from_now, end_date: 1.month.from_now, admin:)

Promotion.create!(name: 'Dia das Mães', discount_percentual: 30, discount_max: 100, usage_limit: 50,
                                    start_date: 1.day.from_now, end_date: 1.week.from_now, admin:)

Promotion.create!(name: 'Dia dos Namorados', discount_percentual: 20, discount_max: 60, usage_limit: 40,
                                    start_date: 1.day.from_now, end_date: 1.week.from_now, admin:)
           
Promotion.create!(name: 'BlackFriday', discount_percentual: 50, discount_max: 200, usage_limit: 100,
                  start_date: 1.day.from_now, end_date: 1.month.from_now, admin:)

Promotion.create!(name: 'Dia das Mães', discount_percentual: 30, discount_max: 100, usage_limit: 50,
                  start_date: 1.day.from_now, end_date: 1.week.from_now, admin:)

Promotion.create!(name: 'Dia dos Namorados', discount_percentual: 20, discount_max: 60, usage_limit: 40,
                  start_date: 1.day.from_now, end_date: 1.week.from_now, admin:)

# Compras
Purchase.create!(client: first_client, value: 2000, status: :approved, message: 'Aprovado com sucesso!')
Purchase.create!(client: second_client, value: 3000, status: :approved, message: 'Aprovado com sucesso!')
Purchase.create!(client: first_client, value: 10000, status: :rejected, message: 'Cliente sem Saldo!')
Purchase.create!(client: first_client, value: 10000, status: :pending)


# Avaliações
Review.create!(product: first_product, client: first_client, rating: 4, comment: 'Boa qualidade de imagem, mas custo benefício ruim.')
Review.create!(product: second_product, client: second_client, rating: 5, comment: 'Casaco Brilha mais que um arco-iris. Tecido altamente resistente, quase um kvlar.')
Review.create!(product: third_product, client: second_client, rating: 3, comment: 'Celular não trava, mas a bateria acaba muito rápido.')
Review.create!(product: fourth_product, client: first_client, rating: 1, comment: 'Camiseta de baixa qualidade, tecido esfarelando e estampa tambem.')