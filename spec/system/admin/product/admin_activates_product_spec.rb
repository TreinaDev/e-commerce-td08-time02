require 'rails_helper'

describe 'Administrador ativa produto' do
  it 'com sucesso' do
    admin = create :admin
    product = create :product, status: :inactive
    create :price, product: product, admin: admin

    login_as(admin, scope: :admin)
    visit product_path(product.id)
    click_on 'Ativar'
    product.reload

    expect(page).to have_content 'Produto ativado com sucesso'
    expect(product).to be_active
  end
end
