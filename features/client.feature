# encoding: utf-8
# language: pt

Funcionalidade: Criação e listagem de clientes na API

Cenário: Criar cliente válido via API
  Dado que se queira criar um cliente válido
  Quando fazer a chamada para criação do cliente
  Então o cliente será criado

Cenário: Consultar cliente cadastrado via API
  Dado que se queira criar um cliente válido
  E fazer a chamada para criação do cliente
  Quando consultar o cliente cadastrado
  Então o cliente é consultado com sucesso

Cenário: Adicionar cartão de crédito a um cliente
  Dado que se queira criar um cliente válido
  E fazer a chamada para criação do cliente
  Quando adicionar um cartão a este cliente
  Então o cliente terá um cartão de crédito associado
