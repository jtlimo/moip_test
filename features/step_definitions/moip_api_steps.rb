# encoding: utf-8
# language: pt

###############################################
############## DADO O CLIENTE   ###############
############## PEDIDO/PAGAMENTO ###############
###############################################
Given(/^que exista um (.*) cadastrado$/) do |type|
  @cliente_atual = client type
  @response = fazer_chamada_api(type)
  validar_resposta_api(type)
end

Given(/^que exista um (.*) realizado$/) do |type|
  @order = order type
  @response = fazer_chamada_api(type)
  @order.id = @response.id
  validar_resposta_api(type)
end

Given(/^que se queira (.+)$/) do |type|
  @cliente_atual = client type
end

Given(/^que o cliente realize um pedido (.+)$/) do |type|
  @order = order type
end

When(/^fazer a chamada para (?:criação|realização) do (cliente|pedido|pagamento)$/) do |type|
  @response = fazer_chamada_api(type)
end

Then(/^o (cliente|pedido|pagamento) será (?:criado|realizado)$/) do |type|
  validar_resposta_api(type)
end

When(/^consultar o (cliente|pedido|pagamento) (?:cadastrado|realizado)$/) do |type|
  validar_resposta_api(type)
  @response = chamada_api_consulta(type)
end

Then(/^o (cliente|pedido|pagamento) é consultado (com|sem) sucesso$/) do |var, type|
  validar_resposta_api(type)
end

When(/^adicionar um (.+)$/) do |type|
  validar_criacao_consulta_cliente
  @credit_card = credit_card type
  @response = associar_cartao_ao_cliente
end

Then(/^o cliente terá um cartão de crédito associado$/) do
  validar_associacao_cartao
end
