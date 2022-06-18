class IncrementItemService
  def initialize(product, client_id)
    @product = product
    @client_id = client_id
    @list = ProductItem.where(client_id: @client_id, product_id: @product.id)
  end

  def call
    return false unless @list.first

    @list.first.quantity += 1
    @list.first.save
  end
end
