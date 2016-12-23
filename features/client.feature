# encoding: utf-8
# language: pt

Funcionalidade: Criação e listagem de clientes na API

@test
Cenário: Criar cliente válido via API
  Dado que se queira criar um cliente válido
  Quando fazer a chamada para criação do cliente
  Então o cliente será criado
