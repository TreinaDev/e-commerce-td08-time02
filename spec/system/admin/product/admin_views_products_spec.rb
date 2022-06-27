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
      expect(page).to have_content '5,00 rubis'
    end
    within("##{second_product.id}") do
      expect(page).to have_content 'Notebook'
      expect(page).to have_content 'Samsung'
      expect(page).to have_content '10,00 rubis'
      expect(page).to have_content 'Inativo'
    end
  end
end
