class GetBalance
  def self.get_balance(code)
    begin
      response = Faraday.get('http://pagamentostreinadev.com/api/v1/balance/')
      body = JSON.parse(response.body)
      return body["data"]["balance"]
    rescue => exception
      return 0
    end
  end
end