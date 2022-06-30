require 'rails_helper'

describe 'Administrador visita a tela de cashbacks registrados' do
  it 'com sucesso' do
    admin = create :admin, name: 'José'
    cashback1 = create :cashback, admin: admin, start_date: Time.zone.today,
                                  end_date: 10.days.from_now, percentual: 15
    cashback2 = create :cashback, admin: admin, start_date: 5.days.from_now,
                                  end_date: 15.days.from_now, percentual: 5

    login_as admin, scope: :admin
    visit root_path
    find('#menu-desktop').click_on 'Cashbacks'

    expect(page).to have_current_path cashbacks_path
    expect(page).to have_content 'Cashbacks Registrados'
    within("##{cashback1.id}") do
      expect(page).to have_content '15%'
      expect(page).to have_content "Início: #{I18n.l(Time.zone.today)}"
      expect(page).to have_content "Final: #{I18n.l(10.days.from_now.to_date)}"
      expect(page).to have_content 'Cadastrado por José'
    end
    within("##{cashback2.id}") do
      expect(page).to have_content '5%'
      expect(page).to have_content "Início: #{I18n.l(5.days.from_now.to_date)}"
      expect(page).to have_content "Final: #{I18n.l(15.days.from_now.to_date)}"
      expect(page).to have_content 'Cadastrado por José'
    end
  end

  it 'e não há cashbacks registrados' do
    admin = create :admin

    login_as admin, scope: :admin
    visit cashbacks_path

    expect(page).to have_content 'Não há cashbacks registrados'
  end
end
