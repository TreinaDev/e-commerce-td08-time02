class PurchaseDataService
  def self.send(purchase)
    json_data = {
      transaction: { order: purchase.code, registered_number: purchase.client.code,
                     value: (purchase.value * 100).to_i, cashback: (purchase.cashback_value * 100).to_i }
    }.to_json
    Faraday.post('http://localhost:4000/api/v1/transactions', json_data, content_type: 'application/json')
  rescue Faraday::ConnectionFailed
    nil
  end

  def self.change_purchase_status(purchase, response)
    response_body = JSON.parse(response.body)
    purchase.approved! if response_body['transaction']['status'] == 'accepted'
    purchase.client.product_items.clear
  end

  def self.status_notice(purchase)
    purchase.approved? ? I18n.t('purchase_confirmed') : I18n.t('purchase_pending')
  end
end
