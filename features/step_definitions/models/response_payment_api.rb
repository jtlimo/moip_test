# Class to manipulate response of Payment API
class ResponsePaymentAPI
  attr_accessor :response_json, :http_code

  def initialize(json, http_code)
    self.response_json = json
    self.http_code = http_code
  end

  def id
    response_json['id']
  end

  def status
    response_json['status']
  end

  def order_data
    {
      parcelas: response_json['installmentCount'],
      taxas: response_json['amount']['fees'],
      total: response_json['amount']['total'],
      currency: response_json['amount']['currency']
    }
  end

  def historico
    [
      {
        data_criacao: format_data(response_json['events']['createdAt']),
        type: response_json['events']['type']
      }
    ]
  end

  def cliente_data
    {
      nome_completo: response_json['fundingInstrument']['creditCard']['holder']['fullname'],
      data_nascimento: response_json['fundingInstrument']['creditCard']['holder']['birthdate'],
      type_document: response_json['fundingInstrument']['creditCard']['holder']['taxDocument']['type'],
      cpf: response_json['fundingInstrument']['creditCard']['holder']['taxDocument']['number']
    }
  end

  def credit_card_data
    {
      id: response_json['fundingInstrument']['creditCard']['id'],
      first_6: response_json['fundingInstrument']['creditCard']['first6'],
      last_4: response_json['fundingInstrument']['creditCard']['last4']
    }
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
