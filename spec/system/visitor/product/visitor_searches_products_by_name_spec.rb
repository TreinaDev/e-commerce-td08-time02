require 'rails_helper'

describe 'Visitante busca produtos' do
  it 'por nome' do
    category = create(:category, name: 'Roupas')
    first_product = create :product, name: 'Shorts Branco', category: category,
                                     description: 'Short branco do Palmeiras 2022'
    create :price, product: first_product
    second_product = create :product, name: 'Camiseta Vermelha', category: category,
                                      description: 'Camiseta do Flamengo 2022'
    create :price, product: second_product
    third_product = create :product, name: 'Jaqueta Vermelha', category: category,
                                     description: 'Jaqueta de Festa Junina 2022'
    create :price, product: third_product
    fourth_product = create :product, name: 'Camiseta Azul', category: category,
                                      description: 'Camiseta do Cruzeiro 2021'
    create :price, product: fourth_product

    visit root_path
    within('#menu-desktop') do
      click_on 'Produtos'
    end
    fill_in 'Buscar', with: 'Vermelha'
    click_on 'Buscar'

    expect(page).to have_content 'Camiseta Vermelha'
    expect(page).to have_content 'Jaqueta Vermelha'
    expect(page).not_to have_content 'Camiseta Azul'
    expect(page).not_to have_content 'Shorts Branco'
  end

  it 'por descrição' do
    category = create(:category, name: 'Eletronicos')
    first_product = create :product, name: 'Galaxy S20', category: category, description: 'Celular 256mb'
    create :price, product: first_product
    second_product = create :product, name: 'TV LED 40 POLEGADAS', category: category, description: 'TV 40 polegadas, FULL HD'
    create :price, product: second_product
    third_product = create :product, name: 'JBL L45d', category: category, description: 'Caixa de Som Portátil 50w'
    create :price, product: third_product

    visit root_path
    within('#menu-desktop') do
      click_on 'Produtos'
    end
    fill_in 'Buscar', with: '256mb'
    click_on 'Buscar'

    expect(page).to have_content 'Galaxy S20'
    expect(page).not_to have_content 'TV LED 40 POLEGADAS'
    expect(page).not_to have_content 'JBL L45d'
  end

  it 'por sku' do
    category = create(:category, name: 'Eletronicos')
    product = create :product, name: 'Galaxy S20', category: category, sku: 'MENP8KU-99999'
    create :price, product: product


    visit root_path
    
    within('#menu-desktop') do
      click_on 'Produtos'
    end
    fill_in 'Buscar', with: 'MENP8KU-99999'
    click_on 'Buscar'

    expect(page).to have_content 'Galaxy S20'
  end

  it 'e não existem equivalências' do
    category = create :category
    first_product = create :product, name: 'Shorts Branco', category: category
    create :price, product: first_product
    second_product = create :product, name: 'Camiseta Vermelha', category: category
    create :price, product: second_product
    third_product = create :product, name: 'Camiseta Azul', category: category
    create :price, product: third_product

    visit root_path
    within('#menu-desktop') do
      click_on 'Produtos'
    end
    fill_in 'Buscar', with: 'Televisão'
    click_on 'Buscar'

    expect(page).to have_content 'Nenhum produto encontrado'
    expect(page).not_to have_content 'Camiseta Vermelha'
    expect(page).not_to have_content 'Camiseta Azul'
    expect(page).not_to have_content 'Shorts Branco'
  end
end
