require 'rails_helper'

describe 'Administrador altera status do produto' do
  context 'para ativo' do
    it 'com sucesso' do
      admin = create :admin
      category = create :category, admin: admin
      product = create :product, category: category, status: :inactive
      create :price, product: product, admin: admin, start_date: Time.zone.today,
                     end_date: 3.months.from_now

      login_as(admin, scope: :admin)
      visit product_path(product.id)
      click_on 'Ativar'
      product.reload

      expect(page).to have_content 'Produto ativado com sucesso'
      expect(product).to be_active
      expect(page).not_to have_button 'Ativar'
      expect(page).to have_button 'Desativar'
    end

    it 'sem que o produto tenha 90 dias de preços futuros' do
      admin = create :admin
      category = create :category, admin: admin
      product = create :product, category: category, status: :inactive
      create :price, product: product, admin: admin, start_date: Time.zone.today,
                     end_date: 1.week.from_now

      login_as(admin, scope: :admin)
      visit product_path(product)
      click_on 'Ativar'
      product.reload

      expect(page).to have_content(
        'Para ser ativado, um produto precisa ter preços cadastrados para os próximos 90 dias'
      )
      expect(product).to be_inactive
      expect(page).to have_button 'Ativar'
      expect(page).not_to have_button 'Desativar'
    end
  end

  context 'para inativo' do
    it 'com sucesso' do
      admin = create :admin
      category = create :category, admin: admin
      product = create :product, category: category, status: :active
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
