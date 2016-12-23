# Generate object Client with DataMagic and .yml file
class Client
  include DataMagic
  attr_accessor :own_id, :nome_completo, :email, :data_nascimento
  attr_accessor :type_document, :cpf, :country_code, :area_code
  attr_accessor :telefone, :zip_code, :street, :street_number
  attr_accessor :complement, :district, :city, :state, :country

  def initialize(create_type)
    obj = data_for "clients/#{create_type}"
    @own_id = obj['own_id']
    @nome_completo = obj['nome_completo']
    @email = obj['email']
    @data_nascimento = obj['data_nascimento']
    @type_document = obj['type_document']
    @cpf = obj['cpf']
    @country_code = obj['country_code']
    @area_code = obj['area_code']
    @telefone = obj['telefone']
    @zip_code = obj['zip_code']
    @street = obj['street']
    @street_number = obj['street_number']
    @complement = obj['complement']
    @district = obj['district']
    @city = obj['city']
    @state = obj['state']
    @country = obj['country']
  end
end
