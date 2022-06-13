require 'rails_helper'

describe 'Administrador vê detalhes de uma categoria' do
  it 'com sucesso' do
    admin = create(:admin, name: 'André')
    category = Category.create!(name: 'Eletronicos', admin:)
    Category.create!(name: 'Celulares', admin:, category:)
    Category.create!(name: 'Computadores', admin:, category:)

    login_as(admin, scope: :admin)
    visit categories_path
    click_on 'Eletronicos'

    expect(page).to have_content 'Eletronicos'
    expect(page).to have_content 'Status: Ativo'
    expect(page).to have_content 'Criado por: André'
    expect(page).to have_content 'Subcategorias'
    expect(page).to have_link 'Celulares'
    expect(page).to have_link 'Computadores'
  end

  it 'e não há subcategorias' do
    admin = create(:admin, name: 'André')
    category = Category.create!(name: 'Eletronicos', admin:)

    login_as(admin, scope: :admin)
    visit category_path(category)

    expect(page).not_to have_content 'Subcategorias'
    expect(page).to have_content 'Não há subcategorias'
  end

  it 'e vê detalhes de uma subcategoria' do
    admin = create(:admin, name: 'André')
    category = Category.create!(name: 'Eletronicos', admin:)
    subcategory = Category.create!(name: 'Celulares', admin:, category:)

    login_as(admin, scope: :admin)
    visit category_path(category)
    click_on 'Celulares'

    expect(page).to have_current_path category_path(subcategory)
  end
end
