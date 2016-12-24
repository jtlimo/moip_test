# Class to manipulate response of Client API
class ResponseOrderAPI
  attr_accessor :response_json, :http_code

  def initialize(json, http_code)
    self.response_json = json
    self.http_code = http_code
  end

  def own_order_id
    response_json['ownId']
  end

  def id
    response_json['id']
  end

  def status
    response_json['status']
  end

  def order_data
    {
      total: response_json['amount']['total'],
      currency: response_json['amount']['currency'],
      sum_shipping_items: response_json['amount']['subtotals']['shipping'] +
        response_json['amount']['subtotals']['items'],
      details: response_json['items'][0]['detail'],
      quantity:   response_json['items'][0]['quantity'],
      product: response_json['items'][0]['product']
    }
  end

  def cliente_data
    {
      id: response_json['customer']['id'],
      own_id: response_json['customer']['ownId'],
      nome_completo: response_json['customer']['fullname'],
      data_nascimento: response_json['customer']['birthDate'],
      email: response_json['customer']['email'],
      telefone: response_json['customer']['phone']['number'],
      area_code: response_json['customer']['phone']['areaCode'],
      country_code: response_json['customer']['phone']['countryCode'],
      type_document: response_json['customer']['taxDocument']['type'],
      cpf: response_json['customer']['taxDocument']['number'],
      zip_code: response_json['customer']['shippingAddress']['zipCode'],
      street: response_json['customer']['shippingAddress']['street'],
      street_number: response_json['customer']['shippingAddress']['streetNumber'],
      complement: response_json['customer']['shippingAddress']['complement'],
      city: response_json['customer']['shippingAddress']['city'],
      district: response_json['customer']['shippingAddress']['district'],
      state: response_json['customer']['shippingAddress']['state'],
      country: response_json['customer']['shippingAddress']['country']
    }
  end

  def moip_account_id
    response_json['moipAccount']['id']
  end

  def data_criacao
    format_data(response_json['createdAt'])
  end

  private

  def format_data(data)
    data = Date.strptime(data, '%Y-%m-%d')
    data.strftime('%d-%m-%Y')
  end
end
