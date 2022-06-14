require 'rails_helper'

describe 'Usuario vê detalhes de um produto' do
  it 'a partir da tela inicial' do
    Product.create!(name: 'Monitor 8k', brand: 'LG', sku: 'MON8K-64792', description: 'Monitor de alta qualidade',
                    width: '100', height: '50', weight: '12', shipping_price: '23', depth: '12', fragile: true)

    visit root_path
    click_on 'Produtos'
    click_on 'Monitor 8k'

    expect(page).to have_current_path product_path(Product.last.id)
    expect(page).to have_content('Inativo')
    expect(page).to have_content('Monitor 8k')
    expect(page).to have_content('Marca: LG')
    expect(page).to have_content('Descrição: Monitor de alta qualidade')
    expect(page).to have_content('SKU: MON8K-64792')
    expect(page).to have_content('Dimensões: 100,00 x 50,00 x 12,00')
    expect(page).to have_content('Peso: 12,00 kg')
    expect(page).to have_content('Preço do Frete: R$ 23,00')
    expect(page).to have_content('Frágil - Sim')
  end
end
