require 'rails_helper'

describe 'Administrador cadastra um produto' do
  it 'a partir da tela inicial' do
    create :exchange_rate, value: 2.00
    admin = create :admin, name: 'João'
    category = create :category, admin: admin
    create :subcategory, name: 'TVs', category: category, admin: admin
    create :cashback, start_date: 1.day.from_now, end_date: 1.month.from_now,
                      percentual: 10, admin: admin
    cashback_string = "10% | #{1.day.from_now.strftime('%d/%m')} - #{1.month.from_now.strftime('%d/%m')}"

    login_as admin, scope: :admin
    visit root_path
    find('#menu-desktop').click_on 'Produtos'
    click_on 'Cadastrar Produto'
    fill_in 'Nome', with: 'TV - LG 45'
    fill_in 'Marca', with: 'LG'
    select 'TVs', from: 'Categorias'
    select cashback_string, from: 'Cashback'
    fill_in 'Descrição', with: 'TV - LG 45 polegadas'
    fill_in 'SKU', with: 'TVLG45-XKFZ'
    fill_in 'Largura', with: '75'
    fill_in 'Altura', with: '45'
    fill_in 'Profundidade', with: '10'
    fill_in 'Peso', with: '4'
    fill_in 'Preço de frete', with: '10'
    check 'Frágil'
    fill_in 'Data final', with: 7.days.from_now
    fill_in 'Valor', with: '20'
    attach_file 'Fotos', [Rails.root.join('spec/support/files/placeholder-image-1.png'),
                          Rails.root.join('spec/support/files/placeholder-image-2.png')]
    attach_file 'Manual', Rails.root.join('spec/support/files/placeholder-manual.pdf')
    click_on 'Cadastrar'

    expect(page).to have_current_path product_path(Product.last)
    expect(page).to have_content('Produto criado com sucesso')
    expect(Product.last.name).to eq 'TV - LG 45'
    expect(Product.last).to be_inactive
    expect(Product.last.brand).to eq 'LG'
    expect(Product.last.category.name).to eq 'TVs'
    expect(Product.last.sku).to eq 'TVLG45-XKFZ'
    expect(Product.last.description).to eq 'TV - LG 45 polegadas'
    expect(Product.last.height).to eq 45.00
    expect(Product.last.width).to eq 75.00
    expect(Product.last.depth).to eq 10.00
    expect(Product.last.weight).to eq 4.00
    expect(Product.last.shipping_price).to eq 10.00
    expect(Product.last.rubies_shipping_price).to eq 5.00
    expect(Product.last).to be_fragile
    expect(Product.last.current_price.value).to eq 20.00
    expect(Product.last.current_price.rubies_value).to eq 10.00
    expect(Product.last.manual).to be_present
    expect(Product.last.photos.count).to eq 2
  end

  it 'com dados incompletos' do
    admin = create :admin

    login_as admin, scope: :admin
    visit new_product_path
    fill_in 'Nome', with: 'Computador'
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
    fill_in 'Valor', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content 'Falha ao cadastrar produto'
    expect(page).to have_field 'Nome', with: 'Computador'
    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'SKU não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'Preço de frete não pode ficar em branco'
    expect(page).not_to have_content 'Frágil não pode ficar em branco'
    expect(page).to have_field 'Data inicial', with: Time.zone.today
    expect(page).to have_content 'Valor não pode ficar em branco'
  end

  it 'com dados incorretos' do
    product = create :product, sku: 'ABCD-1234'

    login_as product.category.admin, scope: :admin
    visit new_product_path
    fill_in 'SKU', with: 'ABCD-1234'
    fill_in 'Largura', with: '-1.0'
    fill_in 'Altura', with: '-1.0'
    fill_in 'Profundidade', with: '-1.0'
    fill_in 'Peso', with: '-1.0'
    fill_in 'Preço de frete', with: '-1.0'
    fill_in 'Data final', with: 1.day.ago
    fill_in 'Valor', with: '-1.0'
    click_on 'Cadastrar'

    expect(page).to have_content 'Falha ao cadastrar produto'
    expect(page).to have_content 'SKU já está em uso'
    expect(page).to have_content 'Largura deve ser maior que 0'
    expect(page).to have_content 'Altura deve ser maior que 0'
    expect(page).to have_content 'Profundidade deve ser maior que 0'
    expect(page).to have_content 'Peso deve ser maior que 0'
    expect(page).to have_content 'Preço de frete deve ser maior que 0'
    expect(page).to have_content 'Data inicial não pode ser maior que a data final'
    expect(page).to have_content 'Valor deve ser maior que 0'
  end
end
