# encoding: utf-8
# language: pt

Given(/^que se queira (.+)$/) do |type|
  @cliente_atual = client type
end

When(/^fazer a chamada para criação do (cliente|pedido|pagamento)$/) do |type|
  @response = fazer_chamada_api(type)
end

Then(/^o (cliente|pedido|pagamento) será criado$/) do |type|
  validar_criacao_consulta_cliente(201)
end

When(/^consultar o (cliente|pedido|pagamento) (?:cadastrado|realizado)$/) do |type|
  validar_criacao_consulta_cliente(201)
  @response = chamada_api_consulta(type)
end

Then(/^o cliente é consultado (com|sem) sucesso$/) do |var|
  validar_criacao_consulta_cliente(200)
end

When(/^adicionar um (.+)$/) do |type|
  validar_criacao_consulta_cliente(201)
  @credit_card = credit_card type
  @response = associar_cartao_ao_cliente
end

Then(/^o cliente terá um cartão de crédito associado$/) do
  validar_associacao_cartao
end
