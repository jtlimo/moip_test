# encoding: utf-8
# language: pt

Funcionalidade: Criação e consultas de pedidos via API

Contexto:
  Dado que exista um cliente válido cadastrado

Cenário: Criar pedido via API
  Dado que o cliente realize um pedido válido
  Quando fazer a chamada para criação do pedido
  Então o pedido será criado

Cenário: Consultar pedido realizado via API
  Dado que o cliente realize um pedido válido
  E fazer a chamada para criação do pedido
  Quando consultar o pedido realizado
  Então o pedido é consultado com sucesso
