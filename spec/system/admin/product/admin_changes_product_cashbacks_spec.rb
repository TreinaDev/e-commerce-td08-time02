require 'rails_helper'

describe 'Administrador altera cashback do produto' do
  it 'com sucesso' do
    admin = create :admin
    create :exchange_rate, value: 2.0
    cashback = create :cashback, admin: admin, percentual: 10
    create :cashback, admin: admin, percentual: 5
    product = create :product, cashback: cashback, name: 'Monitor 8k', status: :active
    create :price, product: product, admin: admin, start_date: Time.zone.today,
                   end_date: 90.days.from_now

    login_as(admin, scope: :admin)
    visit product_path(product)
    select 5, from: 'product[cashback_id]'
    click_on 'Redefinir cashback'
    product.reload

    expect(product.cashback.percentual).to eq 5
    expect(page).to have_content 'Cashback Atualizado!'
    expect(page).to have_content 'Monitor 8k'
    expect(page).to have_content 'Cashback de 5%'
    expect(page).to have_content 'Ativo'
  end
end
