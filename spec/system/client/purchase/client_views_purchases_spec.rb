require 'rails_helper'

describe 'Cliente visualiza compras realizadas' do
  it 'com sucesso' do
    client = create :client
    create :exchange_rate, value: 2.0
    first_product = create :product, name: 'Monitor 8k', shipping_price: 10.00
    create :price, product: first_product, value: 20.00
    second_product = create :product, name: 'Celular i12', shipping_price: 20.00
    create :price, product: second_product, value: 40.00
    first_purchase = create :purchase, client: client, status: :approved, value: 45.00
    second_purchase = create :purchase, client: client, status: :pending, value: 30.00
    create :product_item, purchase: first_purchase, product: first_product, quantity: 1
    create :product_item, purchase: first_purchase, product: second_product, quantity: 1
    create :product_item, purchase: second_purchase, product: first_product, quantity: 2

    login_as client, scope: :client
    visit root_path
    find('#menu-desktop').click_on 'Minhas Compras'

    expect(page).to have_current_path purchases_path
    within('.list') do
      expect(page).to have_content 'Minhas Compras'
    end
    within("##{first_purchase.id}") do
      expect(page).to have_content "#{I18n.l(Time.zone.today)}"
      expect(page).to have_content '$ 45,00'
      expect(page).to have_content 'Aprovada'
    end
    within("##{second_purchase.id}") do
      expect(page).to have_content "Data\n#{I18n.l(Time.zone.today)}"
      expect(page).to have_content '$ 30,00'
      expect(page).to have_content 'Pendente'
    end
  end

  it 'e vê uma compra rejeitada' do
    client = create :client
    create :exchange_rate, value: 2.0
    product = create :product, name: 'Monitor 8k', shipping_price: 10.00
    create :price, product: product, value: 20.00
    purchase = create :purchase, client: client, status: :rejected,
                                 value: 30.0, message: 'Saldo Insuficiente'
    create :product_item, purchase: purchase, product: product, quantity: 2

    login_as client, scope: :client
    visit purchases_path

    within("##{purchase.id}") do
      expect(page).to have_content "Data: #{I18n.l(Time.zone.today)}"
      expect(page).to have_content '2 x Monitor 8k'
      expect(page).to have_content 'Valor Total: $30,00 rubis'
      expect(page).to have_content 'Rejeitada'
      expect(page).to have_content 'Motivo: Saldo Insuficiente'
    end
  end

  it 'e não há nenhuma' do
    client = create :client

    login_as client, scope: :client
    visit purchases_path

    expect(page).to have_content 'Você ainda não realizou nenhuma compra.'
  end
end
