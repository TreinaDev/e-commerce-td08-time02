require 'rails_helper'

describe 'Administrador visita o menu de compras dos clientes' do
  it 'e busca compras de um cliente por nome' do
    client = create :client, name: 'Marquinhos', code: '510.309.910-14'
    create :client, :another_email, name: 'Marquinhos José', code: '61.887.261/0001-60'
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
    expect(page).not_to have_content 'Cliente não encontrado.'
    within("##{purchase1.id}") do
      expect(page).to have_content "Data\n#{I18n.l(Time.zone.today)}"
      expect(page).to have_content "Valor Total\n$ 15,00"
      expect(page).to have_content 'Aprovada'
    end
    within("##{purchase2.id}") do
      expect(page).to have_content "Data\n#{I18n.l(Time.zone.today)}"
      expect(page).to have_content "Valor Total\n$ 30,00"
      expect(page).to have_content 'Pendente'
    end
  end

  it 'e busca compras de um cliente por CPF' do
    client = create :client, name: 'Marquinhos', code: '510.309.910-14'
    create :client, :another_email, name: 'Marquinhos José', code: '61.887.261/0001-60'
    create :exchange_rate, value: 2.0
    product = create :product, name: 'Monitor 8k', shipping_price: 10.00
    create :price, product: product, value: 20.00
    purchase = create :purchase, client: client, status: :approved, value: 15.00
    create :product_item, purchase: purchase, product: product, quantity: 1

    login_as product.category.admin, scope: :admin
    visit purchases_path
    fill_in 'Nome ou CPF/CNPJ do cliente', with: '510.309.910-14'
    click_on 'Buscar'

    expect(page).to have_content 'Marquinhos (510.309.910-14)'
    expect(page).not_to have_content 'Cliente não encontrado.'
    within("##{purchase.id}") do
      expect(page).to have_content "Data\n#{I18n.l(Time.zone.today)}"
      expect(page).to have_content "Valor Total\n$ 15,00"
      expect(page).to have_content 'Aprovada'
    end
  end

  it 'e não encontra um cliente na busca' do
    admin = create :admin
    create :client, name: 'Marquinhos'

    login_as admin, scope: :admin
    visit purchases_path
    fill_in 'Nome ou CPF/CNPJ do cliente', with: 'José'
    click_on 'Buscar'

    expect(page).not_to have_content 'Marquinhos'
    expect(page).to have_content 'Cliente não encontrado.'
  end

  it 'e faz a busca sem dados' do
    admin = create :admin
    client = create :client, name: 'Marquinhos', code: '510.309.910-14'
    create :exchange_rate, value: 2.0
    product = create :product, name: 'Monitor 8k', shipping_price: 10.00
    create :price, product: product, value: 20.00
    purchase = create :purchase, client: client, status: :approved, value: 15.00
    create :product_item, purchase: purchase, product: product, quantity: 1

    login_as admin, scope: :admin
    visit purchases_path
    click_on 'Buscar'

    expect(page).to have_content 'Cliente não encontrado.'
    expect(page).not_to have_content 'Marquinhos (510.309.910-14)'
    expect(page).not_to have_content "Data\n#{I18n.l(Time.zone.today)}"
    expect(page).not_to have_content "Valor Total\n$ 15,00"
    expect(page).not_to have_content 'Aprovada'
  end
end
