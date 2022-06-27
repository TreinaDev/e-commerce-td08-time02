require 'rails_helper'

describe 'Visitante vê todos os produtos' do
  it 'a partir da tela inicial' do
    create :exchange_rate, value: 2.0
    product1 = create :product, name: 'Monitor 8k', brand: 'LG'
    product1.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                           filename: 'placeholder-image-1.png', content_type: 'image/png')
    create :price, product: product1, start_date: Time.zone.today, end_date: 1.day.from_now, value: 10.00
    create :price, product: product1, start_date: 2.days.from_now, end_date: 90.days.from_now, value: 20.00
    product2 = create :product, category: product1.category, name: 'Monitor 4k', brand: 'Samsung'
    product2.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-2.png')),
                           filename: 'placeholder-image-2.png', content_type: 'image/png')
    create :price, product: product2, start_date: Time.zone.today, end_date: 1.day.from_now, value: 20.00
    create :price, product: product2, start_date: 2.days.from_now, end_date: 90.days.from_now, value: 40.00

    visit root_path
    find('#menu-desktop').click_on 'Produtos'

    expect(page).to have_current_path products_path
    expect(page).not_to have_link('Cadastrar Produto')
    within("##{product1.id}") do
      expect(page).to have_content('Monitor 8k')
      expect(page).to have_content('Marca: LG')
      expect(page).to have_css("img[src*='placeholder-image-1.png']")
      expect(page).to have_content('5,00 rubis')
    end
    within("##{product2.id}") do
      expect(page).to have_content('Monitor 4k')
      expect(page).to have_content('Marca: Samsung')
      expect(page).to have_css("img[src*='placeholder-image-2.png']")
      expect(page).to have_content('10,00 rubis')
    end
  end

  it 'e não existem produtos cadastrados' do
    visit root_path
    find('#menu-desktop').click_on 'Produtos'

    expect(page).to have_content 'Nenhum produto encontrado'
  end

  it 'e não vê produtos inativos' do
    create :exchange_rate, value: 2.0
    first_product = create :product, name: 'Monitor 8k', brand: 'LG', status: :active
    create :price, product: first_product, value: 10.00
    second_product = create :product, category: first_product.category, name: 'Notebook', brand: 'Samsung',
                                      status: :inactive
    create :price, product: second_product, value: 20.00

    visit products_path
    within("##{first_product.id}") do
      expect(page).to have_content 'Monitor 8k'
      expect(page).to have_content 'LG'
      expect(page).to have_content '5,00 rubis'
    end
    expect(page).not_to have_content 'Notebook'
    expect(page).not_to have_content 'Samsung'
    expect(page).not_to have_content '10,00 rubis'
  end
end
