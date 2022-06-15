require 'rails_helper'

describe 'Administrador altera status do produto' do
  context 'para ativo' do
    it 'com sucesso' do
      admin = create :admin
      product = create :product, status: :inactive
      create :price, product: product, admin: admin

      login_as(admin, scope: :admin)
      visit product_path(product.id)
      click_on 'Ativar'
      product.reload

      expect(page).to have_content 'Produto ativado com sucesso'
      expect(product).to be_active
      expect(page).not_to have_button 'Ativar'
      expect(page).to have_button 'Desativar'
    end
  end

  context 'para inativo' do
    it 'com sucesso' do
      admin = create :admin
      product = create :product, status: :active
      create :price, product: product, admin: admin

      login_as(admin, scope: :admin)
      visit product_path(product.id)
      click_on 'Desativar'
      product.reload

      expect(page).to have_content 'Produto desativado com sucesso'
      expect(product).to be_inactive
      expect(page).not_to have_button 'Desativar'
      expect(page).to have_button 'Ativar'
    end
  end
end
