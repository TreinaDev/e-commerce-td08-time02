require 'rails_helper'

describe 'Administrador visita o menu de compras dos clientes' do
  it 'e vê a listagem dos clientes que realizaram compras' do
    client = create :client, name: 'Marquinhos'
    create :client, :another_email, :another_code, name: 'Juliana'
    create :exchange_rate
    product = create :product
    create :price, product: product
    purchase = create :purchase, client: client, value: 20.00
    create :product_item, purchase: purchase, product: product

    login_as product.category.admin, scope: :admin
    visit root_path
    find('#menu-desktop').click_on 'Todas as Compras'

    within('#clients') do
      expect(page).to have_button 'Marquinhos'
      expect(page).not_to have_button 'Juliana'
    end
  end
end

# client1 = create :client, name: 'João'
# client2 = create :client, name: 'Maria'
# create :exchange_rate, value: 2.0
# product = create :product, name: 'Monitor 8k', shipping_price: 10.00
# create :price, product: product, value: 20.00
# purchase1 = create :purchase, client: client1, status: :approved, value: 15.00
# item1 = create :product_item, purchase: purchase1, product: product, quantity: 1
