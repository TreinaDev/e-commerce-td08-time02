require 'rails_helper'

describe 'Cliente vê carrinho' do
  it 'e vê produtos adicionados ao carrinho' do
    client = create :client
    admin = create(:admin)
    category = create(:category, admin:)
    create(:product, name: 'Monitor 8k', status: :active, category:)
    product = create(:product, name: 'Mouse', status: :active, category:)

    login_as client, scope: :client
    visit products_path
    click_on 'Monitor 8k'
    click_on 'Adicionar ao carrinho'
    visit product_path(product)
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'

    expect(page).to have_content 'Meu Carrinho'
    expect(page).to have_content 'Monitor 8k'
    expect(page).to have_content '1'
    expect(page).to have_content 'Mouse'
  end

  it 'e não há produtos duplicados' do
    client = create :client
    admin = create(:admin)
    category = create(:category, admin:)
    product = create(:product, name: 'Mouse', status: :active, category:)

    login_as client, scope: :client
    visit product_path(product)
    click_on 'Adicionar ao carrinho'
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'

    expect(page).to have_content 'Mouse'
    expect(page).to have_content '2'
    expect(ProductItem.count).to eq 1
  end

  it 'e não há produtos no carrinho' do
    client = create :client

    login_as client, scope: :client
    visit root_path
    click_on 'Carrinho'

    expect(page).to have_content 'Não há produtos no carrinho'
  end
end
