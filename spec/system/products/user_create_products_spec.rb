require 'rails_helper'

describe 'Usuário cadastra um produto' do
  it 'a partir da tela inicial' do
    # Arrange
    # user = Admin.create!(name: 'Administrador', email: 'admin@mercadores.com.br', password: 'password', status: 'approved')
    # Act
    # login_as(user)
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
    fill_in 'Peso', with: '4500'
    fill_in 'Preço do Frete', with: '47'
    check   'Frágil'
    click_on 'Cadastrar'


    # Assert
    expect(page).to have_content('TV - LG 45')
    expect(current_path).to eq product_path(1)
    expect(page).to have_content('Marca: LG')
    expect(page).to have_content('Descrição: TV - LG 45 polegadas')
    expect(page).to have_content('SKU: TVLG45-XKFZ')
    expect(page).to have_content('Dimensões: 75x45x10')
    expect(page).to have_content('Peso: 4500')
    expect(page).to have_content('Valor do Frete: 47')
    expect(page).to have_content('Frágil - Sim')
    expect(page).to have_content('Pendente de Pagamento')


  end
end