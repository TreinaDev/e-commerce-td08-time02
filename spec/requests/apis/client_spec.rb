require 'rails_helper'

describe 'Client Balance API' do
  context 'POST /api/v1/clients/update-balance' do
    it 'Bem-sucedido' do
      client = create :client, code: '61.887.261/0001-60', balance: 0.0

      post '/api/v1/clients/update-balance', params: { registered_number: '61.887.261/0001-60', balance: 5078 }
      client.reload

      expect(client.balance).to eq 50.78
    end
  end
end
