require 'rest_client'
require 'json'
require 'base64'

# API class to create / get clients of Moips and add payment methods to clients
class APIClient
  AUTH = 'Basic ' + Base64.strict_encode64("#{TOKEN}:#{KEY}")
  CLIENT_API_URL = "https://#{MOIP_URL}/v2/customers".freeze

  def self.create_client(client)
    json = {
      ownId: client.own_id, fullname: client.nome_completo,
      email: client.email, birthDate: client.data_nascimento,
      taxDocument: {
        type: client.type_document, number: client.cpf
      },
      phone: {
        countryCode: client.country_code, areaCode: client.area_code,
        number: client.telefone
      },
      shippingAddress: {
        city: client.city, complement: client.complement,
        district: client.district, street: client.street,
        streetNumber: client.street_number, zipCode: client.zip_code,
        state: client.state, country: client.country
      }
    }
    RestClient.post(CLIENT_API_URL, json.to_json, content_type: :json, accept: :json, Authorization: AUTH) do |response, _request, _result|
      return ResponseClientAPI.new(JSON.parse(response), response.code)
    end
  end

  def self.get_client(customer_id)
    RestClient.get(CLIENT_API_URL + "/#{customer_id}", content_type: :json, accept: :json) do |response, _request, _result|
      return ResponseClientAPI.new(JSON.parse(response), response.code)
    end
  end

  def self.add_payment_method_to_client(client, credit_card)
    json = {
      method: credit_card.method,
      creditCard: {
        expirationMonth: credit_card.expiration_month,
        expirationYear: credit_card.expiration_year,
        number: credit_card.number, cvc: credit_card.cvc,
        holder: {
          fullname: client.nome_completo, birthdate: client.data_nascimento,
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
    RestClient.post(CLIENT_API_URL, json.to_json, content_type: :json, accept: :json) do |response, _request, _result|
      return ResponseClientAPI.new(JSON.parse(response))
    end
  end
end
