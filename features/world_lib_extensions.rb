module Lib
  def generate_client_with(type)
    Client.new type
  end

  def generate_credit_card_with(type)
    CreditCard.new type
  end

  def client(type)
    clients = {
      'criar um cliente válido': :create_accepted_client
    }.freeze
    generate_client_with (clients[type.downcase.to_sym])
  end

  def credit_card(type)
    credit_cards = {
      'adicionar cartão válido': :accepted_credit_card
    }.freeze
    generate_credit_card_with (credit_cards[type.downcase.to_sym])
  end
end
World(Lib)
