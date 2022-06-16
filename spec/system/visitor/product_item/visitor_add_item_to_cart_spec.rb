require 'rails_helper'

describe 'Visitante adiciona um item ao carrinho' do
  it 'com sucesso' do
    admin = create(:admin)
    category = create(:category, admin:)
    create(:product, name: 'Monitor 8k', status: :active, category:)

    visit products_path
    click_on 'Monitor 8k'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_content 'Monitor 8k adicionado ao carrinho!'
  end

  it 'com falha' do
    admin = create(:admin)
    category = create(:category, admin:)
    product = create(:product, name: 'Monitor 8k', status: :active, category:)
    allow(ProductItem).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)

    visit products_path
    click_on 'Monitor 8k'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_content 'Não foi possível adicionar ao carrinho'
    expect(page).to have_current_path product_path(product)
  end
end
