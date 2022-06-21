require 'rails_helper'

describe 'Administrador cadastra novo preço para produto' do
  it 'com sucesso' do
    product = create :product
    old_price = create :price, product: product, admin: product.category.admin, end_date: 1.week.from_now,
                               value: 35.00

    login_as product.category.admin, scope: :admin
    visit product_path(product)
    fill_in 'Data final', with: 2.weeks.from_now
    fill_in 'Valor', with: 201.89
    click_on 'Cadastrar preço'

    expect(page).to have_current_path product_path(product)
    expect(page).to have_content 'Preço cadastrado com sucesso'
    expect(page).to have_content(
      "Preço para #{I18n.l((old_price.end_date + 1).to_date)} - " \
      "#{I18n.l(2.weeks.from_now.to_date)}: R$ 201,89 - Cadastrado por: #{product.category.admin.name}"
    )
  end
end
