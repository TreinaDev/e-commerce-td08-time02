class IncrementItemService
  def initialize(product, client)
    @item = ProductItem.find_by(client_id: client, product_id: product)
  end

  def edit_quantity
    @item&.quantity += 1
    @item&.save
  end
end
