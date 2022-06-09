require 'rails_helper'

describe 'Administrador cria categoria' do
  it 'com sucesso' do
    Category.create!(name: 'Alimentos')

    visit root_path
    click_on 'Criar Categoria'
    fill_in 'Nome', with: 'Fruta'
    select 'Alimentos', from: 'Categoria'
    click_on 'cadastrar'
    
    category = Category.where(name: 'Fruta')
    expect(category.length).to eq 1
    expect(category[0].category.name).to eq 'Alimentos'
    expect(page).to have_content 'E-Commerce'
  end
end