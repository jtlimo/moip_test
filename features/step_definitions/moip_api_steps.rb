# encoding: utf-8
# language: pt

Given(/^que se queira (.+)$/) do |type|
  @cliente_atual = client type
end

When(/^fazer a chamada para criação do (cliente|pedido|pagamento)$/) do |type|
  @response = fazer_chamada_api(type)
end

Then(/^o (cliente|pedido|pagamento) será criado$/) do |type|
  validar_criacao(type)
end
