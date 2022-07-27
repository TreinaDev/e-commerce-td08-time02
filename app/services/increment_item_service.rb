class IncrementItemService
  def initialize(product, client)
    @item = ProductItem.find_by(client_id: client, product_id: product)
    @product = product
  end

  def edit_quantity
    @item&.decrease_stock(@product)
    @item&.quantity += 1
    @item&.save
  end
end
