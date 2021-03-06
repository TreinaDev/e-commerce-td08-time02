require 'rails_helper'

describe 'Administrador cria' do
  context 'supercategoria' do
    it 'com sucesso' do
      admin = create(:admin)
      create(:promotion, name: 'BlackFriday', admin:)

      login_as(admin, scope: :admin)
      visit root_path
      find('#menu-desktop').click_on 'Categorias'
      click_on 'Criar Categoria'
      fill_in 'Nome', with: 'Alimentos'
      select 'BlackFriday', from: 'Selecione promoção relacionada'
      click_on 'Cadastrar'
      category = Category.last

      expect(page).to have_current_path categories_path
      expect(page).to have_content 'Categoria Cadastrada com Sucesso!'
      expect(category.name).to eq 'Alimentos'
      expect(category.admin_id).to eq admin.id
      expect(category.promotion.name).to eq 'BlackFriday'
      expect(page).to have_content 'Alimentos'
    end

    it 'com campos vazios' do
      admin = create(:admin)

      login_as(admin, scope: :admin)
      visit new_category_path
      fill_in 'Nome', with: ''
      click_on 'Cadastrar'

      expect(page).to have_current_path categories_path
      expect(page).to have_content 'Não foi possível cadastrar a categoria'
    end
  end

  context 'subcategoria' do
    it 'com sucesso' do
      admin = create(:admin)
      category = create(:category, name: 'Alimentos', admin_id: admin.id)

      login_as(admin, scope: :admin)
      visit new_category_path
      fill_in 'Nome', with: 'Frutas'
      select 'Alimentos', from: 'Selecione categoria relacionada'
      click_on 'Cadastrar'

      expect(Category.last.name).to eq 'Frutas'
      expect(category.name).to eq 'Alimentos'
    end

    it 'a partir da tela de detalhes da categoria' do
      admin = create(:admin, name: 'André')
      category = create(:category, name: 'Eletrônicos', admin:)

      login_as(admin, scope: :admin)
      visit category_path(category)
      click_on 'Criar subcategoria'
      fill_in 'Nome', with: 'Celulares'
      select 'Eletrônicos', from: 'Selecione categoria relacionada'
      click_on 'Cadastrar'

      expect(Category.last.name).to eq 'Celulares'
    end
  end
end
