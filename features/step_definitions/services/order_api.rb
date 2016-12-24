require 'rest_client'
require 'json'
require 'base64'

# API class to create / get and list orders
class APIOrders
  AUTH = 'Basic ' + Base64.strict_encode64("#{TOKEN}:#{KEY}")
  ORDER_API_URL = "https://#{MOIP_URL}/v2/orders".freeze

  def self.create_order(client, order_itens)
    json = {
      ownId: client.own_id,
      amount: {
        currency: order_itens.currency,
        subtotals: {
          shipping: order_itens.shipping
        }
      },
      items: [
        {
          product: order_itens.product, quantity: order_itens.quantity,
          detail: order_itens.detail, price: order_itens.price
        }
      ],
      customer: {
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
    }
    RestClient.post(ORDER_API_URL, json.to_json, content_type: :json, accept: :json, Authorization: AUTH) do |response, _request, _result|
      return ResponseOrderAPI.new(JSON.parse(response), response.code)
    end
  end

  def self.get_order(order_id)
    RestClient.get(ORDER_API_URL + "/#{order_id}", content_type: :json, accept: :json, Authorization: AUTH) do |response, _request, _result|
      return ResponseOrderAPI.new(JSON.parse(response), response.code)
    end
  end

  def self.list_orders(query)
    params = { q: query }
    RestClient.get(CLIENT_API_URL, { params: params }, content_type: :json, accept: :json, Authorization: AUTH) do |response, _request, _result|
      return ResponseOrderAPI.new(JSON.parse(response), response.code)
    end
  end
end
