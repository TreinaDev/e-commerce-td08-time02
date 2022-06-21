require 'rails_helper'

describe 'Visitante vê detalhes de um produto' do
  it 'a partir da tela de produtos' do
    category = create(:category, name: 'Eletrônicos')
    product = create(:product, name: 'Monitor 8k', brand: 'LG', description: 'Monitor de alta qualidade',
                               sku: 'MON8K-64792', height: 50, width: 100, depth: 12, weight: 12,
                               shipping_price: 23, fragile: true, status: :active, category: category)
    product.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                          filename: 'placeholder-image-1.png', content_type: 'image/png')
    create(:price, product: product, admin: product.category.admin, start_date: Time.zone.today,
                   end_date: 1.week.from_now, value: 50.00)
    create(:price, product: product, admin: product.category.admin, start_date: 8.days.from_now,
                   end_date: 2.weeks.from_now, value: 100.00)

    visit products_path
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
    expect(page).to have_content('Preço do Frete: R$ 23,00')
    expect(page).to have_content('Frágil - Sim')
    expect(page).to have_content('Preço: R$ 50,00')
    expect(page).not_to have_content('Ativo')
    expect(page).not_to have_content("Preço para #{I18n.l(Time.zone.today)} - #{I18n.l(1.week.from_now)}: " \
                                     "R$ 50,00 - Cadastrado por: #{category.admin.name}")
    expect(page).not_to have_content("Preço para #{I18n.l(8.days.from_now)} - #{I18n.l(2.weeks.from_now)}: " \
                                     "R$ 100,00 - Cadastrado por: #{category.admin.name}")
  end
end
