# Class to manipulate response of Client API
class ResponseClientAPI
  attr_accessor :response_json

  def initialize(json)
    self.response_json = json
  end

  def id
    response_json['id']
  end

  def errors
    response_json['errors']
  end

  def nome_campanha
    response_json['name']
  end

  def status
    response_json['status']
  end

  def data_ativacao
    format_data(response_json['activated_at'])
  end

  def data_inativacao
    format_data(response_json['inactivated_at'])
  end

  def data_criacao
    format_data(response_json['created_at'])
  end

  def data_ultimo_update
    format_data(response_json['updated_at'])
  end

  def porcentagem
    response_json['percentage']
  end

  def campanhas
    response_json
  end

  private

  def format_data(data)
    data = Date.strptime(data, '%Y-%m-%d')
    data.strftime('%d-%m-%Y')
  end
end
