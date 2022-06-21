require 'rails_helper'

describe 'Visitante filtra produtos por categoria' do
  it 'super-categoria mostra seus produtos e também das suas sub-categorias' do
    category = create :category, name: 'Roupas'
    other_category = create :category, name: 'Eletrônicos',
                                       admin: create(:admin, email: 'outroadmin@mercadores.com.br')
    create :product, name: 'Shorts vermelho', category: category
    create :product, name: 'Shorts azul', category: category
    create :product, name: 'Galaxy S20', category: other_category

    visit root_path
    click_on 'Produtos'
    click_on 'Roupas'
    
    expect(page).to have_content('Shorts vermelho')
    expect(page).to have_content('Shorts azul')
    expect(page).not_to have_content('Galaxy S20')
  end

  it 'sub-categoria não mostra produtos da super-categoria' do
    category = create :category, name: 'Roupas'
    other_category = create :category, category:, name: 'Shorts',
                                       admin: create(:admin, email: 'outroadmin@mercadores.com.br')
    create :product, name: 'Camisa vermelha', category: category
    create :product, name: 'Shorts azul', category: other_category

    visit root_path
    click_on 'Produtos'
    click_on 'Shorts'

    expect(page).to have_content('Shorts azul')
    expect(page).not_to have_content('Camisa vermelha')
  end
end