require 'rails_helper'

describe 'Usuário cadastra um produto' do
  it 'deve estar autenticado' do
    visit new_product_path

    expect(current_path).to eq new_admin_session_path
  end

  it 'a partir da tela inicial' do
    user = Admin.create!(name: 'Administrador', email: 'admin@mercadores.com.br', password: 'password', status: 'approved')
    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar Produto'

    fill_in 'Nome', with: 'TV - LG 45'
    fill_in 'Marca', with: 'LG'
    fill_in 'Descrição', with: 'TV - LG 45 polegadas'
    fill_in 'SKU', with: 'TVLG45-XKFZ'
    fill_in 'Manual', with: ''
    fill_in 'Largura', with: '75'
    fill_in 'Altura', with: '45'
    fill_in 'Profundidade', with: '10'
    fill_in 'Peso', with: '4'
    fill_in 'Preço do Frete', with: '47'
    check   'Frágil'
    click_on 'Cadastrar'

    expect(page).to have_content('TV - LG 45')
    expect(current_path).to eq product_path(Product.last.id)
    expect(page).to have_content('Marca: LG')
    expect(page).to have_content('Descrição: TV - LG 45 polegadas')
    expect(page).to have_content('SKU: TVLG45-XKFZ')
    expect(page).to have_content('Dimensões: 75,00x45,00x10,00')
    expect(page).to have_content('Peso: 4,00kg')
    expect(page).to have_content('Preço do Frete: R$ 47,00')
    expect(page).to have_content('Frágil - Sim')
    expect(page).to have_content('Produto Inativo')
    expect(page).to have_content('Produto criado com sucesso')
  end

  it 'com dados incompletos' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar Produto'

    fill_in 'Nome', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'SKU', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Profundidade', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Preço do Frete', with: ''
    check   'Frágil'
    click_on 'Cadastrar'
    
    expect(page).to have_content 'Falha ao cadastrar produto'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'SKU não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
  end
end 