require 'rails_helper'

describe 'Administrador altera status do produto' do
  context 'para ativo' do
    it 'com sucesso' do
      product = create :product, status: :inactive
      create :price, product: product, admin: product.category.admin, start_date: Time.zone.today,
                     end_date: 90.days.from_now

      login_as(product.category.admin, scope: :admin)
      visit product_path(product)
      click_on 'Ativar'
      product.reload

      expect(page).to have_current_path product_path(product)
      expect(product).to be_active
      expect(page).to have_content 'Produto ativado com sucesso'
      expect(page).not_to have_button 'Ativar'
      expect(page).to have_button 'Desativar'
    end

    it 'sem que o produto tenha 90 dias de preços futuros' do
      product = create :product, status: :inactive
      create :price, product: product, admin: product.category.admin, start_date: Time.zone.today,
                     end_date: 45.days.from_now
      create :price, product: product, admin: product.category.admin, start_date: 46.days.from_now,
                     end_date: 89.days.from_now

      login_as(product.category.admin, scope: :admin)
      visit product_path(product)
      click_on 'Ativar'
      product.reload

      expect(page).to have_current_path activate_product_path(product)
      expect(product).to be_inactive
      expect(page).to have_content(
        'Para ser ativado, um produto precisa ter preços cadastrados para os próximos 90 dias'
      )
      expect(page).to have_button 'Ativar'
      expect(page).not_to have_button 'Desativar'
    end
  end

  context 'para inativo' do
    it 'com sucesso' do
      product = create :product, status: :active
      create :price, product: product, admin: product.category.admin

      login_as(product.category.admin, scope: :admin)
      visit product_path(product)
      click_on 'Desativar'
      product.reload

      expect(page).to have_content 'Produto desativado com sucesso'
      expect(product).to be_inactive
      expect(page).not_to have_button 'Desativar'
      expect(page).to have_button 'Ativar'
    end
  end
end
