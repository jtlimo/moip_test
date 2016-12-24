module Lib
  def generate_client_with(type)
    Client.new type
  end

  def generate_credit_card_with(type)
    CreditCard.new type
  end

  def generate_order_with(type)
    Orders.new type
  end

  def client(type)
    clients = {
      'criar um cliente válido': :create_accepted_client,
      'cliente válido': :create_accepted_client
    }.freeze
    generate_client_with (clients[type.downcase.to_sym])
  end

  def credit_card(type)
    credit_cards = {
      'adicionar cartão válido': :accepted_credit_card,
      'cartão a este cliente': :accepted_credit_card
    }.freeze
    generate_credit_card_with (credit_cards[type.downcase.to_sym])
  end

  def order(type)
    orders = {
      'válido': :accepted_order,
      'pedido válido': :accepted_order
    }.freeze
    generate_order_with (orders[type.downcase.to_sym])
  end
end
World(Lib)
