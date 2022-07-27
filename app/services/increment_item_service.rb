class IncrementItemService
  def initialize(product, client)
    @item = ProductItem.find_by(client_id: client, product_id: product)
    @product = product
  end

  def edit_quantity
    @item&.change_stock(@product, -1)
    @item&.quantity += 1
    @item&.save
  end
end
