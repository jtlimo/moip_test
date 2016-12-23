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

  def chamada_api_consulta(type)
    case type
    when 'cliente'
      APIClient.get_client(@response.id)
    when 'pedido'
      APIOrders.get_order(@response.id)
    when 'pagamento'
      APIPayment.get_payment(@response.id)
    end
  end

  def validar_criacao_consulta_cliente(status_code)
    expect(@response.http_code).to eq status_code # validate http_code response
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
    @cliente_atual.id = @response.id
  end

  def associar_cartao_ao_cliente
    APIClient.add_payment_method_to_client(@cliente_atual, @credit_card)
  end

  def validar_associacao_cartao
    expect(@response.http_code).to eq 201 # validate http_code response
    expect(@response.method).to eq @credit_card.method
    expect(@response.credit_card_first_6)
      .to eq @credit_card.number.to_s.chars.first(6).join
    expect(@response.credit_card_last_4)
      .to eq @credit_card.number.to_s.chars.last(4).join
  end
end
World(Commons)
