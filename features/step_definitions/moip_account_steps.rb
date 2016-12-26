# encoding: utf-8
# language: pt

Given(/^que esteja nos detalhes do pedido$/) do
  login_page.load
  login_page.do_login
  account_summary.access_order_details(@cliente_atual.own_id)
end

Então(/^os dados estarão corretos$/) do
  expect(order_details.validate_order_details(@cliente_atual,
                                              @order)).to be true
end
