require 'rails_helper'

describe 'Administrador vê categorias' do
  it 'com sucesso' do
    admin = Admin.create!(email: 'joão@mercadores.com.br', password: 'joão1234', status: :approved)
    Category.create!(name: 'Eletronicos', admin: admin)
    Category.create!(name: 'Alimentos', admin: admin)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Categorias'

    expect(page).to have_link 'Eletronicos'
    expect(page).to have_link 'Alimentos'
  end
end
