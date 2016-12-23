require 'rest_client'
require 'json'
require 'base64'

# API class to create / get and list payments
class APIPayment
  ENCODING = Base64.strict_encode64("#{TOKEN}:#{KEY}")
  ORDER_API_URL = "https://#{ENCODING}@#{MOIP_URL}/v2/orders".freeze
  PAYMENT_API_URL = "https://#{ENCODING}@#{MOIP_URL}/v2/payments".freeze

  def self.create_payment(client, credit_card, order_id)
    json = {
      installmentCount: 1,
      fundingInstrument: {
        method: credit_card.method,
        creditCard: {
          hash: credit_card.hash,
          holder: {
            fullname: client.nome_completo, email: client.email,
            birthDate: client.data_nascimento,
            taxDocument: {
              type: client.type_document, number: client.cpf
            },
            phone: {
              countryCode: client.country_code, areaCode: client.area_code,
              number: client.telefone
            }
          }
        }
      }
    }
    RestClient.post(ORDER_API_URL + "/#{order_id}/payments", json.to_json, content_type: :json, accept: :json) do |response, _request, _result|
      return ResponsePaymentAPI.new(JSON.parse(response))
    end
  end

  def self.get_order(payment_id)
    RestClient.get(PAYMENT_API_URL + "/#{payment_id}", content_type: :json, accept: :json) do |response, _request, _result|
      return ResponsePaymentAPI.new(JSON.parse(response))
    end
  end
end
