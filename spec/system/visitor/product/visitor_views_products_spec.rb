require 'rails_helper'

describe 'Visitante vê todos os produtos' do
  it 'a partir da tela inicial' do
    admin = create(:admin)
    category = Category.create!(name: 'Alimentos', admin_id: admin.id)
    product1 = create :product, name: 'Monitor 8k', brand: 'LG', category: category
    product1.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-1.png')),
                           filename: 'placeholder-image-1.png', content_type: 'image/png')
    product2 = create :product, name: 'Monitor 4k', brand: 'Samsung', category: category
    product2.photos.attach(io: File.open(Rails.root.join('spec/support/files/placeholder-image-2.png')),
                           filename: 'placeholder-image-2.png', content_type: 'image/png')

    visit root_path
    click_on 'Produtos'

    expect(page).to have_current_path products_path
    expect(page).to have_content('Monitor 8k')
    expect(page).to have_content('Marca: LG')
    expect(page).to have_css("img[src*='placeholder-image-1.png']")
    expect(page).to have_content('Monitor 4k')
    expect(page).to have_content('Marca: Samsung')
    expect(page).to have_css("img[src*='placeholder-image-2.png']")
  end

  it 'não existe produtos cadastrados' do
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Nenhum produto cadastrado'
  end
end
