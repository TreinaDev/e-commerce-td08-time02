require 'rails_helper'

describe 'Administrador cria categoria' do
  Category.create!(name: 'Alimentos')

  it 'com sucesso' do
    visit root_path
    click_on 'Criar Categoria'
    fill_in 'Nome', with: 'Uva'
    select 'Alimentos', from: 'Categoria'
    click_on 'cadastrar'
    
    category = Category.where(name: 'Uva')
    expect(category.length).to eq 1
  end
end