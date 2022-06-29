require 'rails_helper'

describe 'Visitante filtra produtos por categoria' do
  it 'super-categoria mostra seus produtos e também das suas sub-categorias' do
    create :exchange_rate
    first_category = create :category, name: 'Roupas', status: :active
    other_category = create :category, admin: first_category.admin, name: 'Eletrônicos', status: :active
    visible_product1 = create :product, name: 'Shorts vermelho', category: first_category
    create :price, product: visible_product1
    visible_product2 = create :product, name: 'Shorts azul', category: first_category
    create :price, product: visible_product2
    invisible_product = create :product, name: 'Galaxy S20', category: other_category
    create :price, product: invisible_product

    visit root_path
    find('#menu-desktop').click_on 'Produtos'
    click_on 'Roupas'

    expect(page).to have_content('Shorts vermelho')
    expect(page).to have_content('Shorts azul')
    expect(page).not_to have_content('Galaxy S20')
  end

  it 'sub-categoria não mostra produtos da super-categoria' do
    create :exchange_rate
    category = create :category, name: 'Roupas'
    subcategory = create :subcategory, category: category, name: 'Shorts'
    invisible_product = create :product, name: 'Camisa vermelha', category: category
    create :price, product: invisible_product
    visible_product = create :product, name: 'Shorts azul', category: subcategory
    create :price, product: visible_product

    visit products_path
    click_on 'Shorts'

    expect(page).to have_content('Shorts azul')
    expect(page).not_to have_content('Camisa vermelha')
  end

  it 'não vê categoria desativada' do
    create :category, name: 'Roupas', status: :disabled

    visit products_path

    expect(page).not_to have_link('Roupas')
  end
end
