require 'rails_helper'

describe 'Administrador cria promoção' do
  it 'com sucesso' do
    admin = create(:admin)

    login_as admin, scope: :admin
    visit root_path
    find('#menu-desktop').click_on 'Promoções'
    click_on 'Criar Promoção'
    fill_in 'Nome', with: 'BlackFriday'
    fill_in 'Percentual de Desconto', with: '50'
    fill_in 'Limite de Desconto', with: '100'
    fill_in 'Limite de uso', with: '20'
    fill_in 'Data Inicial', with: 1.day.from_now
    fill_in 'Data Final', with: 1.week.from_now
    click_on 'cadastrar'

    expect(page).to have_content('Promoção cadastrada com sucesso')
    expect(page).to have_content('Nome: BlackFriday')
    expect(page).to have_content('Percentual de Desconto: 50%')
    expect(page).to have_content('Quantidade Máxima de Desconto: R$ 100')
    expect(page).to have_content('Quantidade utilizada: 0 | Limite de uso: 20')
    expect(page).to have_content("Início: #{I18n.l(1.day.from_now.to_date)} | Final: #{I18n.l(1.week.from_now.to_date)}")
    expect(page).to have_content('Validade: Futura')
  end

  it 'com campos não preenchidos' do
    admin = create(:admin)

    login_as admin, scope: :admin
    visit root_path
    find('#menu-desktop').click_on 'Promoções'
    click_on 'Criar Promoção'
    fill_in 'Nome', with: ''
    fill_in 'Percentual de Desconto', with: ''
    fill_in 'Limite de Desconto', with: ''
    fill_in 'Limite de uso', with: ''
    fill_in 'Data Inicial', with: ''
    fill_in 'Data Final', with: ''
    click_on 'cadastrar'

    expect(page).to have_current_path promotions_path
    expect(page).to have_content('Não foi possível cadastrar a promoção')
    expect(page).not_to have_content('Promoção cadastrada com sucesso!')
  end
end