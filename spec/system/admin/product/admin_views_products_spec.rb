require 'rails_helper'

describe 'Administrador vê todos os produtos' do
  it 'e vê produtos inativos' do
    first_product = create :product, name: 'Monitor 8k', brand: 'LG', status: :active
    create :product, category: first_product.category, name: 'Notebook', brand: 'Samsung', status: :inactive

    login_as first_product.category.admin, scope: :admin
    visit products_path

    expect(page).to have_content 'Monitor 8k'
    expect(page).to have_content 'LG'
    within('#Notebook') do
      expect(page).to have_content 'Notebook'
      expect(page).to have_content 'Samsung'
      expect(page).to have_content 'Inativo'
    end
  end
end
