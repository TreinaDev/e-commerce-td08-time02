require 'rails_helper'

describe 'Administrador acessa detalhes do produto' do
  it 'e produto não existe' do
    admin = create :admin

    login_as admin, scope: :admin
    visit product_path(999)

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Produto inativo ou inexistente'
  end
end
