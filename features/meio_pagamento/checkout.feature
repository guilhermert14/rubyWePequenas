#language: pt

Funcionalidade: Realizar a compra de um produto com todas as formas de entrega e pagamentos.
  formas de entrega: Normal, Expressa, Retira Rapido, Agendada
  formas de pagamento: Cartão de Crédito, Boleto, Paypal, Cartão Presente, Masterpass

Contexto:

  Dado que acesso o site

Esquema do Cenario: Finalizar uma compra com forma de pagamento cartao de credito e boleto

  E adiciono um produto "notebook" no carrinho
  E seleciono o produto desejado com garantia de "nao"
  E preencho minha identificacao com usuario "usuarioBlackList"
  E seleciono a forma de entrega "Normal"
  Quando preencho a forma de pagamento <forma_pagamento>
  Entao valido a url de finalizacao da compra

  Exemplos:
  |        forma_pagamento        |
  |           "boleto"            |
  |   "um_cartao_credito_master"  |
  | "dois_cartoes_credito_master" |
