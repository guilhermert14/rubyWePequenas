Dado(/^seleciono a forma de entrega "([^"]*)"$/) do |forma|
  @common.forma_entrega(forma)
end

Dado(/^seleciono o produto desejado com garantia de "([^"]*)"$/) do |garantia|
  @paginaGarantia.seleciona_garantia(garantia) if garantia != "nao"
  @paginaGarantia.continua_garantia
  @assertPage.valida_existencia_elemento(EL['botao_concluir_compra'])
  @common.clica_elemento("botao_concluir_compra")
end

Quando(/^preencho a forma de pagamento "([^"]*)"$/) do |formaPagamento|
  if formaPagamento == "boleto"

    @paginaPagamento.seleciona_forma_pagamento(formaPagamento)
    assert_selector(EL['botao_finalizar_compra_boleto'], wait: 30, visible: true)
    sleep (1)
    @common.clica_elemento("botao_finalizar_compra_boleto")

  elsif formaPagamento.include?("debito_online")

    tipo_debito = formaPagamento.split("_")
    assert_selector('.paymentMethods', wait: 30, visible: true)
    sleep (1)
    @paginaPagamento.seleciona_forma_pagamento(tipo_debito[0])
    assert_selector('.debitoContent', wait: 30, visible: true)
    @paginaPagamento.finaliza_debito(tipo_debito[2])

  elsif formaPagamento.include?("credito")
    
    bandeira = formaPagamento.split("_")
    formaPagamento = "#{bandeira[0]}_#{bandeira[1]}_#{bandeira[2]}"
    assert_selector(EL['campo_formas_pagamento'], wait: 30, visible: true)
    @paginaPagamento.seleciona_forma_pagamento(formaPagamento)
    @paginaPagamento.send("preenche_#{formaPagamento}", bandeira[3])
    @common.clica_elemento("botao_finalizar_compra_cartao")

  elsif formaPagamento.include?("boleto_cartao")

    @paginaPagamento.preencho_boleto_cartao
    @common.clica_elemento("botao_concluir_pagamento")

  elsif formaPagamento.include?("paypal")

    assert_selector(EL["botao_paypal"], wait: 30, visible: true)
    @paginaPagamento.seleciona_forma_pagamento(formaPagamento)
    @common.clica_elemento("botao_finalizar_paypal")
    @assertPage.valida_existencia_elemento('main[id="main"]')

  elsif formaPagamento.include?("visa_checkout")

    assert_selector(EL["botao_visa_checkout"], wait: 30, visible: true)
    @paginaPagamento.seleciona_forma_pagamento(formaPagamento)
    @common.clica_elemento("botao_finalizar_visa_checkout")
    @assertPage.valida_existencia_elemento("#vcop-src-frame")

  elsif formaPagamento.include?("masterpass")

    assert_selector(EL["botao_masterpass"], wait: 15, visible: true)
    @paginaPagamento.seleciona_forma_pagamento(formaPagamento)
    @common.clica_elemento("botao_finalizar_masterpass")
    @assertPage.valida_existencia_elemento("#vcop-src-frame")

  else

    @paginaPagamento.seleciona_forma_pagamento(formaPagamento)
    @paginaPagamento.send("preenche_#{formaPagamento}")
    @common.clica_elemento("botao_concluir_pagamento")

  end

end
