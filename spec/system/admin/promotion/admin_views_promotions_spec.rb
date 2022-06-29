require 'rails_helper'

describe 'Administrador ve todas as promoções' do
  it 'com sucesso' do
    admin = create :admin
    promotion = create :promotion, name: 'BlackFriday', discount_percentual: 50, usage_limit: 10, 
                       start_date: 1.day.from_now.to_date, end_date: 1.month.from_now.to_date,
                       admin: admin

    login_as admin, scope: :admin
    visit root_path
    find('#menu-desktop').click_on 'Promoções'

    expect(page).to have_link "#{promotion.coupon}"
    expect(page).to have_content 'Lista de Promoções'
    expect(page).to have_content 'Nome: BlackFriday'
    expect(page).to have_content 'Percentual de Desconto: 50%'
    expect(page).to have_content 'Quantidade utilizada: 0 | Limite de uso: 10'
    expect(page).to have_content "Início: #{I18n.l(1.day.from_now.to_date)} | Final: #{I18n.l(1.month.from_now.to_date)}"
  end

  it 'sem promoções cadastradas' do
    admin = create :admin

    login_as admin, scope: :admin
    visit promotions_path

    expect(page).to have_content 'Não há promoções cadastradas'
  end
end