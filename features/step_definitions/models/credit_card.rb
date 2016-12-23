# Generate object CreditCard with DataMagic and .yml file
class CreditCard
  include DataMagic
  attr_accessor :method, :expiration_month, :expiration_year, :number, :cvc, :hash

  def initialize(create_type)
    obj = data_for "credit_card/#{create_type}"
    @method = obj['method']
    @expiration_month = obj['expiration_month']
    @expiration_year = obj['expiration_year']
    @number = obj['number']
    @cvc = obj['cvc']
    @hash = obj['hash']
  end
end
