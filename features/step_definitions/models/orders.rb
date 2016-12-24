# Generate object Orders with DataMagic and .yml file
class Orders
  include DataMagic

  attr_accessor :own_id, :currency, :shipping, :product
  attr_accessor :quantity, :detail, :price, :id

  def initialize(create_type)
    obj = data_for "orders/#{create_type}"
    @own_id = obj['own_id']
    @currency = obj['currency']
    @shipping = obj['shipping']
    @product = obj['product']
    @quantity = obj['quantity']
    @detail = obj['detail']
    @price = obj['price']
    @id = obj['id']
  end
end
