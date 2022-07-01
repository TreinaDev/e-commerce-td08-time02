require 'rails_helper'

describe 'Purchase API' do
  context 'POST /api/v1/purchases/update-status' do
    it 'Rejeita a compra com sucesso' do
      client = create :client
      item = create :product_item, client: client
      allow(SecureRandom).to receive(:alphanumeric).and_return('DOK3KRGA')
      first_purchase = create :purchase, client: client, product_items: [item], value: 20.0, status: :pending

      post '/api/v1/purchases/update-status', params: { code: 'DOK3KRGA', status: :rejected,
                                                        message: 'Compra rejeitada' }
      first_purchase.reload

      expect(first_purchase).to be_rejected
      expect(first_purchase.message).to eq 'Compra rejeitada'
      expect(client.product_items).not_to be_empty
    end

    it 'Aprova a compra com sucesso' do
      client = create :client
      allow(SecureRandom).to receive(:alphanumeric).and_return('DOK3KRGA')
      purchase = create :purchase, client: client, value: 50.0, status: :pending

      post '/api/v1/purchases/update-status', params: { code: 'DOK3KRGA', status: :approved,
                                                        message: 'Compra aprovada' }
      purchase.reload

      expect(purchase).to be_approved
      expect(purchase.message).to eq 'Compra aprovada'
    end
  end
end
