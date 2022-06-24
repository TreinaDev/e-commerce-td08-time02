require 'rails_helper'

describe 'Administrador vê detalhes de uma categoria' do
  it 'com sucesso' do
    admin = create(:admin, name: 'André')
    category = create(:category, name: 'Eletrônicos', admin: admin, status: :disabled)
    create(:subcategory, name: 'Celulares', category: category)
    create(:subcategory, name: 'Computadores', category: category)

    login_as(admin, scope: :admin)
    visit categories_path
    click_on 'Eletrônicos'

    expect(page).to have_content 'Eletrônicos'
    expect(page).to have_content 'Status: Desativada'
    expect(page).to have_content 'Criado por: André'
    expect(page).to have_content 'Subcategorias'
    expect(page).to have_link 'Celulares'
    expect(page).to have_link 'Computadores'
  end

  it 'e não há subcategorias' do
    admin = create(:admin)
    category = create(:category, admin:)

    login_as(admin, scope: :admin)
    visit category_path(category)

    expect(page).to have_content 'Não há subcategorias'
  end

  it 'e vê detalhes de uma subcategoria' do
    admin = create(:admin)
    category = create(:category, admin:)
    subcategory = create(:category, name: 'Celulares', admin:, category:)

    login_as(admin, scope: :admin)
    visit category_path(category)
    click_on 'Celulares'

    expect(page).to have_current_path category_path(subcategory)
  end

  it 'e volta para a tela anterior' do
    admin = create(:admin)
    category = create(:category, admin:)

    login_as(admin, scope: :admin)
    visit category_path(category)
    click_on 'Voltar'

    expect(page).to have_current_path categories_path
  end

  it 'acessa subcategoria e volta para tela anterior' do
    admin = create(:admin)
    category = create(:category, admin:)
    subcategory = create(:category, name: 'Celulares', admin:, category:)

    login_as(admin, scope: :admin)
    visit category_path(subcategory)
    click_on 'Voltar'

    expect(page).to have_current_path category_path(category)
  end
end
