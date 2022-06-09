require 'rails_helper'

describe 'Usuário vê produtos ' do
  it 'a partir da tela inicial' do
    Product.create!(name: 'Monitor 8k', brand: 'LG', sku: 'MON8K-64792',
                      description: 'Monitor de auta qualidade', width: '100', height: '50',
                      weight: '12', shipping_price: '23', depth: '12', fragile: true)
    Product.create!(name: 'Monitor 4k', brand: 'Samsumg', sku: 'MON4K-56792',
                      description: 'Monitor 4k de auta qualidade', width: '110', height: '60',
                      weight: '20', shipping_price: '26', depth: '12', fragile: true)

    visit root_path
    click_on 'Produtos'

    expect(current_path).to eq products_path
    expect(page).to have_content('Monitor 8k')   
    expect(page).to have_content('Marca: LG')
    #expect(page).to have_content('Descrição: Monitor de auta qualidade')
    expect(page).to have_content('SKU: MON8K-64792')
    #expect(page).to have_content('Dimensões: 100x50x12')
    #expect(page).to have_content('Peso: 12kg')
    #expect(page).to have_content('Valor do Frete: 23')
    #expect(page).to have_content('Frágil - Sim')
    #expect(page).to have_content('Pendente de Pagamento')

    expect(page).to have_content('Monitor 4k')
    expect(page).to have_content('Marca: Samsumg')
    expect(page).to have_content('SKU: MON4K-56792')
  end
end