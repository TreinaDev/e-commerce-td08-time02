require 'rails_helper'

describe 'Administrador cadastra um produto' do
  it 'a partir da tela inicial' do
    admin = create :admin
    first_category = create(:category, admin:)
    second_category = create(:category, name: 'Periféricos', category: first_category, admin:)

    login_as admin, scope: :admin
    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar Produto'
    fill_in 'Nome', with: 'TV - LG 45'
    fill_in 'Marca', with: 'LG'
    select('Periféricos', from: 'Categorias')
    fill_in 'Descrição', with: 'TV - LG 45 polegadas'
    fill_in 'SKU', with: 'TVLG45-XKFZ'
    fill_in 'Largura', with: '75'
    fill_in 'Altura', with: '45'
    fill_in 'Profundidade', with: '10'
    fill_in 'Peso', with: '4'
    fill_in 'Preço de frete', with: '47'
    check 'Frágil'
    attach_file 'Fotos', [Rails.root.join('spec/support/files/placeholder-image-1.png'),
                          Rails.root.join('spec/support/files/placeholder-image-2.png')]
    attach_file 'Manual', Rails.root.join('spec/support/files/placeholder-manual.pdf')
    click_on 'Cadastrar'

    expect(page).to have_current_path product_path(Product.last.id)
    expect(page).to have_content('Produto criado com sucesso')
    expect(page).to have_content('TV - LG 45')
    expect(page).to have_css("img[src*='placeholder-image-1.png']")
    expect(page).to have_css("img[src*='placeholder-image-2.png']")
    expect(page).to have_content('Status: Inativo')
    expect(page).to have_content('Marca: LG')
    expect(page).to have_content("Categorias: #{first_category.name} > #{second_category.name}")
    expect(page).to have_content('SKU: TVLG45-XKFZ')
    expect(page).to have_content('Descrição: TV - LG 45 polegadas')
    expect(page).to have_content('Dimensões: 75,00 x 45,00 x 10,00')
    expect(page).to have_content('Peso: 4,00 kg')
    expect(page).to have_content('Preço do Frete: R$ 47,00')
    expect(page).to have_content('Frágil - Sim')
    expect(page).to have_link('Manual')
  end

  it 'com dados incompletos' do
    admin = create :admin
    login_as admin, scope: :admin

    visit new_product_path
    fill_in 'Nome', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Descrição', with: ''
    select('[Sem categoria relacionada]', from: 'Categorias')
    fill_in 'SKU', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Profundidade', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Preço de frete', with: ''
    uncheck 'Frágil'
    click_on 'Cadastrar'

    expect(page).to have_content 'Falha ao cadastrar produto'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'SKU não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
    expect(page).not_to have_content 'Frágil não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
  end
end
