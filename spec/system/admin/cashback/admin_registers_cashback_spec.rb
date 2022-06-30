require 'rails_helper'

describe 'Administrador cria cashback' do
  it 'com sucesso' do
    admin = create :admin

    login_as admin, scope: :admin
    visit cashbacks_path
    click_on 'Cadastrar Cashback'
    fill_in 'Data Inicial', with: 1.day.from_now
    fill_in 'Data Final', with: 1.month.from_now
    fill_in 'Percentual de Cashback', with: '30'
    click_on 'cadastrar'

    expect(Cashback.all.length).to eq 1
    expect(Cashback.last.percentual).to eq 30
    expect(Cashback.last.start_date).to eq 1.day.from_now.to_date
    expect(Cashback.last.end_date).to eq 1.month.from_now.to_date
  end

  it 'sem os dados necessários' do
    admin = create :admin

    login_as admin, scope: :admin
    visit new_cashback_path
    click_on 'cadastrar'

    expect(page).to have_current_path cashbacks_path
    expect(Cashback.all.length).to eq 0
  end
end
