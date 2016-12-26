# OrderDetailsPage class
class OrderDetailsPage < SitePrism::Page
  include RSpec::Matchers

  element :total_value,           '#amount-detail.valor.clickable'
  element :client_details,        '.label-detail.blue.thin.info.span8'
  element :client_tel_date_birth, '.span4:last-child'
  element :client_cpf,            '.span4:first-child'
  element :table_payments,        '.table.table-bordered.table-advance.order-payments'

  def validate_order_details(client, order)
    date = DateTime.parse(client.data_nascimento)
    formatted_date = date.strftime('%d/%m/%y')
    total = total_value.text.delete(total_value.text["R\$"]).to_i
    email = client_details.text[/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i]
    name =  client_details.text.split(email).join.strip
    order_equal?(total: total, email: email, name: name,
                 formatted_date: formatted_date, client: client, order: order)
  end

  def order_equal?(options = {})
    expect(options[:total]).to eq((options[:order].price.to_i + options[:order].shipping.to_i) / 100)
    expect(options[:name]).to eq options[:client].nome_completo
    expect(options[:email]).to eq options[:client].email
    client_tel_date_birth.text.delete('-').include?(options[:client].telefone.to_s)
    client_tel_date_birth.text.include?(options[:formatted_date])
  end
end
