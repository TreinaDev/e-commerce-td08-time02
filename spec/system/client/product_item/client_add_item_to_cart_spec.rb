require 'rails_helper'

describe 'Cliente adiciona um item ao carrinho' do
  it 'sem estar autenticado' do
    create(:product, name: 'Monitor 8k', status: :active)

    visit products_path
    click_on 'Monitor 8k'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_current_path new_client_session_path
  end

  it 'com sucesso' do
    client = create :client
    create(:product, name: 'Monitor 8k', status: :active)

    login_as client, scope: :client
    visit products_path
    click_on 'Monitor 8k'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_content 'Monitor 8k adicionado ao carrinho!'
  end

  it 'com falha' do
    client = create :client
    product = create(:product, name: 'Monitor 8k', status: :active)
    allow(ProductItem).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)

    login_as client, scope: :client
    visit products_path
    click_on 'Monitor 8k'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_content 'Não foi possível adicionar ao carrinho'
    expect(page).to have_current_path product_path(product)
  end
end
