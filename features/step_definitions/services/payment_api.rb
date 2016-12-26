require 'rest_client'
require 'json'
require 'base64'

# API class to create / get and list payments
class APIPayment
  AUTH = 'Basic ' + Base64.strict_encode64("#{TOKEN}:#{KEY}")
  ORDER_API_URL = "https://#{MOIP_URL}/v2/orders".freeze
  PAYMENT_API_URL = "https://#{MOIP_URL}/v2/payments".freeze

  def self.create_payment(client, credit_card, order_id)
    json =
      {
        installmentCount: 1,
        fundingInstrument: {
          method: credit_card.method,
          creditCard: {
            hash: credit_card.hash,
            holder: {
              fullname: client.nome_completo,
              birthdate: client.data_nascimento,
              taxDocument: {
                type: client.type_document,
                number: client.cpf
              },
              phone: {
                countryCode: client.country_code,
                areaCode: client.area_code,
                number: client.telefone
              }
            }
          }
        }
      }
    RestClient.post(ORDER_API_URL + "/#{order_id}/payments", json.to_json, content_type: :json, accept: :json, Authorization: AUTH) do |response, _request, _result|
      return ResponsePaymentAPI.new(JSON.parse(response), response.code)
    end
  end

  def self.get_payment(payment_id)
    RestClient.get(PAYMENT_API_URL + "/#{payment_id}", content_type: :json, accept: :json, Authorization: AUTH) do |response, _request, _result|
      return ResponsePaymentAPI.new(JSON.parse(response), response.code)
    end
  end
end
