class SendPurchaseDataService
  def self.response_status(purchase)
    json_data = { transaction: { registered_number: purchase.client.code, value: purchase.value } }.to_json
    response = Faraday.post('http://localhost:4000/api/v1/transactions', json_data, content_type: 'application/json')
    response_json = JSON.parse(response.body)
    response_json['transaction']['status']
  end
end
