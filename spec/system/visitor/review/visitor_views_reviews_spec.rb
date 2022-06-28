require 'rails_helper'

describe 'Visitante vê todas avaliações cadastradas' do
  it 'a partir da tela inicial' do
    product = create :product
    price = create :price, product: product, admin: product.category.admin, end_date: 1.week.from_now,
                               value: 35.00
    review = create :review, product: product, rating:3

    visit root_path
    click_on 'Produtos'
    click_on 'TV 45'

    expect(page).to have_current_path product_path(product)
    expect(page).not_to have_link('Cadastrar Produto')
    expect(page).to have_content('TV 45')
    expect(page).to have_content('Avaliação: 3')
    expect(page).to have_content('Gostei muito! Recomendo!')
  end

  it 'e não existem avaliações cadastradas' do
    product = create :product
    price = create :price, product: product, admin: product.category.admin, end_date: 1.week.from_now,
                               value: 35.00

    visit root_path
    click_on 'Produtos'
    click_on 'TV 45'

    expect(page).to have_content 'Não há avaliação cadastrada'
  end
end
