require 'rails_helper'

describe 'Cliente visualiza o próprio saldo' do
  it 'com sucesso' do
    client = create(:client)
    login_as client, scope: :client

    visit root_path

    within('nav') do
      expect(page).to have_content('500 Rubis')
    end
  end
end