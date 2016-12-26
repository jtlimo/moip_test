# encoding: utf-8
# language: pt

Funcionalidade: Criação e consultas de pagamentos via API

Contexto:
  Dado que exista um cliente válido cadastrado
  E adicionar um cartão a este cliente
  E que exista um pedido válido realizado

Cenário: Realizar pagamento do pedido via API
  Quando fazer a chamada para realização do pagamento
  Então o pagamento será realizado

Cenário: Consultar pagamento realizado via API
  Dado fazer a chamada para realização do pagamento
  Quando consultar o pagamento realizado
  Então o pagamento é consultado com sucesso
