# helper to validate APIS
module Commons
  def fazer_chamada_api(type)
    case type
    when 'cliente'
      APIClient.create_client(@cliente_atual)
    when 'pedido'
      APIOrders.create_order(@cliente_atual, @order)
    when 'pagamento'
      APIPayment.create_payment(@cliente_atual, @credit_card, @order.id)
    end
  end

  def validar_criacao(_type)
    expect(@response.http_code).to eq 201 # validate http_code response
    expect(@response.data_criacao).to eq Date.today.strftime('%d-%m-%Y')
    validar_cliente_values
  end

  def obj_to_hash(object)
    object.instance_variables.each_with_object({}) do |var, hash|
      hash[var[1..-1].to_sym] = object.instance_variable_get(var)
    end
  end

  def validar_cliente_values
    hash = obj_to_hash(@cliente_atual)
    expect(@response.cliente_data.each_pair.any? do |key, value|
      hash[key].to_s.eql?(value)
    end).to be true # validate client data
  end
end
World(Commons)
