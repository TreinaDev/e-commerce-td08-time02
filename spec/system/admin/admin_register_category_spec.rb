require 'rails_helper'

describe 'Administrador cria categoria' do
  context 'super categoria' do
    it 'com sucesso' do
      admin = Admin.create!(email: 'joão@mercadores.com.br', password: 'joão1234', status: :approved)

      login_as(admin, scope: :admin)
      visit root_path
      click_on 'Categorias'
      click_on 'Criar Categoria'
      fill_in 'Nome', with: 'Alimentos'
      click_on 'cadastrar'
      category = Category.last

      expect(page).to have_current_path categories_path
      expect(page).to have_content 'Categoria Cadastrada com Sucesso!'
      expect(category.name).to eq 'Alimentos'
      expect(category.admin_id).to eq admin.id
      expect(page).to have_content 'Alimentos'
    end

    it 'com campos vazios' do
      admin = Admin.create!(email: 'joão@mercadores.com.br', password: 'joão1234', status: :approved)

      login_as(admin, scope: :admin)
      visit root_path
      click_on 'Categorias'
      click_on 'Criar Categoria'
      fill_in 'Nome', with: ''
      click_on 'cadastrar'

      expect(page).to have_current_path categories_path
      expect(page).to have_content 'Não foi possível cadastrar a categoria'
    end
  end

  context 'subcategoria' do
    it 'com sucesso' do
      admin = Admin.create!(email: 'joão@mercadores.com.br', password: 'joão1234', status: :approved)
      category = Category.create!(name: 'Alimentos', admin_id: admin.id)

      login_as(admin, scope: :admin)
      visit root_path
      click_on 'Categorias'
      click_on 'Criar Categoria'
      fill_in 'Nome', with: 'Frutas'
      select 'Alimentos', from: 'Categoria'
      click_on 'cadastrar'
      subcategory = category.categories.last

      expect(subcategory.name).to eq 'Frutas'
      expect(category.name).to eq 'Alimentos'
      expect(page).to have_content 'Alimentos'
      expect(page).to have_content 'Alimentos > Frutas'
    end
  end
end
