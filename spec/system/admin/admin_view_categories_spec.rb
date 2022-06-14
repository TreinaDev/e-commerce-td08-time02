require 'rails_helper'

describe 'Administrador vê categorias' do
  it 'com sucesso' do
    admin = create(:admin)
    create(:category, name: 'Eletronicos', admin:)
    create(:category, name: 'Alimentos', admin:)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Categorias'

    expect(page).to have_link 'Eletronicos'
    expect(page).to have_link 'Alimentos'
  end

  it 'e não há categorias cadastradas' do
    admin = create(:admin)

    login_as(admin, scope: :admin)
    visit categories_path

    expect(page).to have_content 'Não há categorias cadastradas'
  end
end
