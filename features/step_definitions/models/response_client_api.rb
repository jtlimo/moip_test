# Class to manipulate response of Client API
class ResponseClientAPI
  attr_accessor :response_json, :http_code

  def initialize(json, http_code)
    self.response_json = json
    self.http_code = http_code
  end

  def id
    response_json['id']
  end

  def own_id
    response_json['ownId']
  end

  def cliente_data
    {
      nome_completo: response_json['fullname'],
      data_nascimento: response_json['birthDate'],
      email: response_json['email'],
      telefone: response_json['phone']['number'],
      area_code: response_json['phone']['areaCode'],
      country_code: response_json['phone']['countryCode'],
      type_document: response_json['taxDocument']['type'],
      cpf: response_json['taxDocument']['number'],
      zip_code: response_json['shippingAddress']['zipCode'],
      street: response_json['shippingAddress']['street'],
      street_number: response_json['shippingAddress']['streetNumber'],
      complement: response_json['shippingAddress']['complement'],
      city: response_json['shippingAddress']['city'],
      district: response_json['shippingAddress']['district'],
      state: response_json['shippingAddress']['state'],
      country: response_json['shippingAddress']['country']
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
