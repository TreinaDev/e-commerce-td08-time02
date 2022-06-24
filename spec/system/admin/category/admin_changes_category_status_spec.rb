require 'rails_helper'

describe 'Administrador modifica status da categoria' do
  it 'para desativado' do
    admin = create(:admin)
    category = create :category, admin: admin, status: :active

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Categorias'
    click_on 'Eletrônicos'
    click_on 'Desativar'
    category.reload

    expect(page).to have_current_path category_path(category)
    expect(category).to be_disabled
    expect(page).to have_content 'Categoria desativada com sucesso'
    expect(page).to have_button 'Ativar'
    expect(page).not_to have_button 'Desativar'
  end

  it 'para ativado' do
    admin = create(:admin)
    category = create :category, admin: admin, status: :disabled

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Categorias'
    click_on 'Eletrônicos'
    click_on 'Ativar'
    category.reload

    expect(page).to have_current_path category_path(category)
    expect(category).to be_active
    expect(page).to have_content 'Categoria ativada com sucesso'
    expect(page).to have_button 'Desativar'
    expect(page).not_to have_button 'Ativar'
  end
end
