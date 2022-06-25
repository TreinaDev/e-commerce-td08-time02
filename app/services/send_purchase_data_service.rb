class SendPurchaseDataService
  def self.response_status(purchase)
    json_data = {
      transaction: { order: purchase.id, registered_number: purchase.client.code,
                     value: (purchase.value * 100).to_i, cashback: (purchase.cashback_value * 100).to_i }
    }.to_json
    response = Faraday.post('http://localhost:4000/api/v1/transactions', json_data, content_type: 'application/json')
    return unless response.status == :created

    response_json = JSON.parse(response.body)
    response_json['transaction']['status']
  end
end
