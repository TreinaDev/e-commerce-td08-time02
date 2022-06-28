require 'rails_helper'

describe 'Client Balance API' do
  context 'POST /api/v1/clients/update-balance' do
    it 'Bem-sucedido' do
      client = create :client, code: '61.887.261/0001-60', balance: 0.0

      post '/api/v1/clients/update-balance', params: { registered_number: '61.887.261/0001-60', balance: 5078 }
      client.reload

      expect(response).to have_http_status :created
      expect(response.body).to eq 'Saldo atualizado!'
      expect(client.balance).to eq 50.78
    end

    it 'Com parâmetros faltando' do
      client = create :client, code: '61.887.261/0001-60', balance: 0.0

      post '/api/v1/clients/update-balance', params: { balance: 5078 }
      client.reload

      expect(response).to have_http_status :precondition_failed
      expect(response.body).to include 'CPF/CNPJ não pode ficar em branco'
      expect(response.body).not_to include 'Saldo não pode ficar em branco'
      expect(client.balance).to eq 0.0
    end

    it 'Com CPF/CNPJ inexistente' do
      client = create :client, code: '61.887.261/0001-60', balance: 0.0

      post '/api/v1/clients/update-balance', params: { registered_number: '55.975.952/0001-12', balance: 5078 }
      client.reload

      expect(response).to have_http_status :not_found
      expect(response.body).to include 'CPF/CNPJ não encontrado'
      expect(client.balance).to eq 0.0
    end
  end
end
