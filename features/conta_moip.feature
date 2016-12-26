# encoding: utf-8
# language: pt

Funcionalidade: Detalhes da conta MOIP

Contexto:
  Dado que exista um cliente válido cadastrado
  E adicionar um cartão a este cliente
  E que exista um pedido válido realizado
  Quando fazer a chamada para realização do pagamento
  Então o pagamento será realizado

Cenário: Validar dados na conta Moip após pagamento
  Dado que esteja nos detalhes do pedido
  Então os dados estarão corretos
