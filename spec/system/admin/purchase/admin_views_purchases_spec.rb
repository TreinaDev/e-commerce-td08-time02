require 'rails_helper'

describe 'Administrador visita o menu de compras dos clientes' do
  it 'e busca compras de um cliente por nome' do
    client = create :client, name: 'Marquinhos', code: '510.309.910-14'
    create :exchange_rate, value: 2.0
    product = create :product, name: 'Monitor 8k', shipping_price: 10.00
    create :price, product: product, value: 20.00
    purchase1 = create :purchase, client: client, status: :approved, value: 15.00
    purchase2 = create :purchase, client: client, status: :pending, value: 30.00
    create :product_item, purchase: purchase1, product: product, quantity: 1
    create :product_item, purchase: purchase2, product: product, quantity: 2

    login_as product.category.admin, scope: :admin
    visit root_path
    find('#menu-desktop').click_on 'Todas as Compras'
    fill_in 'Nome ou CPF/CNPJ do cliente', with: 'Marquinhos'
    click_on 'Buscar'

    expect(page).to have_content 'Marquinhos (510.309.910-14)'
    within("##{purchase1.id}") do
      expect(page).to have_content "Data: #{I18n.l(Time.zone.today)}"
      expect(page).to have_content '1 x Monitor 8k'
      expect(page).to have_content 'Valor Total: $15,00 rubis'
      expect(page).to have_content 'Aprovada'
    end
    within("##{purchase2.id}") do
      expect(page).to have_content "Data: #{I18n.l(Time.zone.today)}"
      expect(page).to have_content '2 x Monitor 8k'
      expect(page).to have_content 'Valor Total: $30,00 rubis'
      expect(page).to have_content 'Pendente'
    end
  end

  # it 'e vê as compras de um cliente' do
  #   login_as product.category.admin, scope: :admin
  #   visit root_path
  #   find('#menu-desktop').click_on 'Todas as Compras'
  #   click_on 'Marquinhos'

  # end
end
