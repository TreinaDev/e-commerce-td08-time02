# Admins
admin = Admin.create!(email: 'arthur@mercadores.com.br', password: 'password', name: 'Arthur', status: :approved)
Admin.create!(email: 'marco@mercadores.com.br', password: 'password', name: 'Marco')

# Clientes
Client.create!(email: 'marquinhos@hotmail.com', password: 'password', name: 'Marquinhos', code: '61.887.261/0001-60')
Client.create!(email: 'juliana@hotmail.com', password: 'password', name: 'Juliana', code: '622.894.020-10')
Client.create!(email: 'jadson@hotmail.com', password: 'password', name: 'Jadson', code: '788.460.940-18')

# Categorias
first_category = Category.create!(name: 'Eletronicos', admin:)
second_category = Category.create!(name: 'Roupas', admin:)
third_category = Category.create!(name: 'Celulares', admin:, category: first_category)
fourth_category = Category.create!(name: 'Camisetas', admin:, category: second_category)
Category.create!(name: 'Jardinagem', admin:)

# Produtos
first_product = Product.create!(name: 'Monitor 8k', brand: 'LG', category: first_category,
                                description: 'Monitor de alta qualidade', sku: 'MON8K-64792', height: 50,
                                width: 100, depth: 12, weight: 12, shipping_price: 23, fragile: true,
                                status: :active)
first_product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                            filename: 'placeholder-image-1.png', content_type: 'image/png')
first_product.manual.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-manual.pdf')),
                            filename: 'placeholder-manual.pdf', content_type: 'application/pdf')
Price.create!(admin: admin, product: first_product, start_date: Time.zone.today, end_date: 90.days.from_now,
              value: 1500.00)

second_product = Product.create!(name: 'Casaco da Razer', brand: 'Razer', category: second_category,
                                 description: 'Casaco de Lã de Ovelha', sku: 'CAS8KU-99999', height: 50,
                                 width: 120, depth: 7, weight: 1.5, shipping_price: 50, fragile: false,
                                 status: :active)
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
