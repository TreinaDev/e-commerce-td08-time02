require 'rails_helper'

describe 'Administrador vê todos os produtos' do
  it 'e vê produtos inativos' do
    create :exchange_rate, value: 2.0
    first_product = create :product, name: 'Monitor 8k', brand: 'LG', status: :active
    create :price, product: first_product, value: 10.00
    second_product = create :product, category: first_product.category, name: 'Notebook', brand: 'Samsung',
                                      status: :inactive
    create :price, product: second_product, value: 20.00

    login_as first_product.category.admin, scope: :admin
    visit products_path

    within("##{first_product.id}") do
      expect(page).to have_content 'Monitor 8k'
      expect(page).to have_content 'LG'
      expect(page).to have_content '$5,00'
    end
    within("##{second_product.id}") do
      expect(page).to have_content 'Notebook'
      expect(page).to have_content 'Samsung'
      expect(page).to have_content '$10,00'
      expect(page).to have_content 'Inativo'
    end
  end

  it 'e vê produtos inativos em uma filtragem por categoria' do
    create :exchange_rate
    first_product = create :product, name: 'Monitor 8k', status: :active
    create :price, product: first_product
    second_product = create :product, category: first_product.category, name: 'Notebook',
                                      status: :inactive
    create :price, product: second_product

    login_as first_product.category.admin, scope: :admin
    visit products_path
    click_on first_product.category.name

    expect(page).to have_content 'Monitor 8k'
    expect(page).to have_content 'Notebook'
  end

  it 'e vê produtos inativos em uma busca' do
    create :exchange_rate
    first_product = create :product, name: 'Monitor 8k', status: :active
    create :price, product: first_product
    second_product = create :product, name: 'Monitor 4k', status: :inactive
    create :price, product: second_product

    login_as first_product.category.admin, scope: :admin
    visit products_path
    fill_in 'Buscar', with: 'Monitor'
    click_on 'Buscar'

    expect(page).to have_content 'Monitor 8k'
    expect(page).to have_content 'Monitor 4k'
  end
end
