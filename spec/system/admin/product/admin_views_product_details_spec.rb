require 'rails_helper'

describe 'Administrador acessa detalhes do produto' do
  it 'e produto não existe' do
    admin = create :admin

    login_as admin, scope: :admin
    visit product_path(999)

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Produto inativo ou inexistente'
  end

  it 'e vê preços em reais' do
    admin = create :admin, name: 'João'
    create :exchange_rate, value: 2.0
    category = create(:category, name: 'Eletrônicos', admin: admin)
    product = create(:product, name: 'Monitor 8k', brand: 'LG', description: 'Monitor de alta qualidade',
                               sku: 'MON8K-64792', height: 50, width: 100, depth: 12, weight: 12,
                               shipping_price: 10.00, fragile: true, status: :active, category: category)
    product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                          filename: 'placeholder-image-1.png', content_type: 'image/png')
    create(:price, product: product, admin: admin,
                   start_date: Time.zone.today, end_date: 7.days.from_now, value: 20.00)
    create(:price, product: product, admin: admin,
                   start_date: 8.days.from_now, end_date: 90.days.from_now, value: 100.00)

    login_as admin, scope: :admin
    visit root_path
    click_on 'Monitor 8k'

    expect(page).to have_current_path product_path(Product.last)
    expect(page).to have_content('Monitor 8k')
    expect(page).to have_css("img[src*='placeholder-image-1.png']")
    expect(page).to have_content('Categoria: Eletrônicos')
    expect(page).to have_content('Marca: LG')
    expect(page).to have_content('Descrição: Monitor de alta qualidade')
    expect(page).to have_content('SKU: MON8K-64792')
    expect(page).to have_content('Dimensões: 100,00 x 50,00 x 12,00')
    expect(page).to have_content('Peso: 12,00 kg')
    expect(page).to have_content('Frete: $5,00')
    expect(page).to have_content('Preço do Frete (em reais): R$ 10,00')
    expect(page).to have_content('Frágil - Sim')
    expect(page).to have_content('$10,00')
    expect(page).to have_content('Preço (em reais): R$ 20,00')
    expect(page).to have_content('Ativo')
    expect(page).to have_content("R$ 20,00 - " \
                                 "Cadastrado por #{admin.name}\n" \
                                 "#{I18n.l(Time.zone.today.to_date)} até #{I18n.l(7.days.from_now.to_date)}")
    expect(page).to have_content("R$ 100,00 - " \
                                 "Cadastrado por #{admin.name}\n" \
                                 "#{I18n.l(8.days.from_now.to_date)} até #{I18n.l(90.days.from_now.to_date)}")
    # expect(page).to have_content("Preço para #{I18n.l(8.days.from_now.to_date)} - " \
    #                              "#{I18n.l(90.days.from_now.to_date)}: " \
    #                              "R$ 100,00 - Cadastrado por: #{admin.name}")
    expect(page).not_to have_button 'Adicionar ao Carrinho'
  end

  it 'e vê produto inativo' do
    product = create :product, status: :inactive
    price = create :price, product: product

    login_as price.admin, scope: :admin
    visit product_path(product)

    expect(page).to have_current_path product_path(product)
    expect(page).to have_content('Inativo')
  end

  it 'e vê um produto cujos preços expiraram como inativo' do
    create :exchange_rate, value: 2.0
    product = create :product, name: 'Monitor 8k', brand: 'LG'
    create :price, product: product, value: 10.00, start_date: Time.zone.today, end_date: 45.days.from_now
    create :price, product: product, value: 20.00, start_date: 46.days.from_now, end_date: 90.days.from_now
    product.active!
    allow(Time.zone).to receive(:today).and_return 91.days.from_now

    login_as product.category.admin, scope: :admin
    visit product_path(product)

    expect(page).to have_content 'Inativo'
  end
end
