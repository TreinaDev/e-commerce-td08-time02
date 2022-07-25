require 'rails_helper'

describe 'Admin updates stock of product' do
  it 'changing quantity' do
    admin = create :admin, name: 'João'
    create :exchange_rate, value: 2.0    
    product = create :product
    create :price, product: product

    login_as admin, scope: :admin
    visit root_path
    find('#menu-desktop').click_on 'Estoque'
    fill_in 'value', with: '20'
    click_on 'Alterar'
    product.reload

    expect(page).to have_content product.name
    expect(page).to have_content '20'
    expect(product.stock_product.quantity).to eq 20
  end
end