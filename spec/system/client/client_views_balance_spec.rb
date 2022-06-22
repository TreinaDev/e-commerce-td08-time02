require 'rails_helper'

describe 'Cliente visualiza o próprio saldo' do
  it 'com sucesso' do
    client = create(:client)
    json_data = File.read(Rails.root.join('spec/support/json/client_balance.json'))
    fake_response = double("faraday_response", status: 200, body: json_data)
    allow_any_instance_of(Faraday::Connection).to receive(:get)
    .with("http://localhost:4000/api/v1/client_wallet/balance", { client_wallet: { registered_number: client.code } })
    .and_return(fake_response)
    
    login_as client, scope: :client
    visit root_path

    within('nav') do
      expect(page).to have_content('500 Rubis')
    end
  end
end