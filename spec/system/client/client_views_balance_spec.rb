require 'rails_helper'

describe 'Cliente visualiza o próprio saldo' do
  it 'com sucesso' do
    client = create :client, code: '61.887.261/0001-60', balance: 50.75

    login_as client, scope: :client
    visit root_path

    within('#menu-desktop') do
      expect(page).to have_content('50,75 Rubis')
    end
  end
end
