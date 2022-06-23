require 'rails_helper'

describe 'Administrador vê detalhes de uma promoção' do
  it 'com sucesso' do
    admin = create :admin
    promotion = create :promotion, name: 'BlackFriday', discount_percentual: 50, usage_limit: 10, 
                       start_date: 1.day.from_now.to_date, end_date: 1.month.from_now.to_date,
                       admin: admin, discount_max: 100
    create :category, name: 'Celulares', admin: admin, promotion: promotion

    visit promotions_path
    click_on 'BlackFriday'

    expect(page).to have_content('Detalhes da Promoção')
    expect(page).to have_content('Nome: BlackFriday')
    expect(page).to have_content('Percentual de Desconto: 50%')
    expect(page).to have_content('Quantidade Máxima de Desconto: R$ 100')
    expect(page).to have_content('Quantidade utilizada: 0 | Limite de uso: 10')
    expect(page).to have_content("Início: #{I18n.l(1.day.from_now.to_date)} | Final: #{I18n.l(1.month.from_now.to_date)}")
    expect(page).to have_content('Validade: Futura')
    expect(page).to have_content('Categorias:')
    expect(page).to have_content('Celulares')
  end
end