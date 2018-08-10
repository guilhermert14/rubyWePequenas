class PaginaPagamento

  include RSpec::Matchers
  include Capybara::DSL

  def seleciona_forma_pagamento(formaPagamento)
    assert_selector(".paymentMethods", wait: 30, visible: true)
    find(EL["el_#{formaPagamento}"]['classe'], text: EL["el_#{formaPagamento}"][formaPagamento], wait: 30).click
  end

  def preenche_um_cartao_credito(bandeira = "master", parcela = 1)
    preenche_cartao_credito("cartao_um", 0, bandeira)
    all(EL["cartao_um"]['texto_qtd_parcelas'], wait: 30)[0].set(parcela)
  end


  def finaliza_debito(tipo_debito)
    case tipo_debito

      when "itau"
        Common.new.clica_elemento("debito_itau")
        sleep 1
        Common.new.clica_elemento("botao_concluir_pagamento")
      when "visa"
        Common.new.clica_elemento("debito_visa")
        sleep 1
        Common.new.clica_elemento("botao_concluir_pagamento")
      when "maestro"
        Common.new.clica_elemento("debito_maestro")
        sleep 1
        Common.new.clica_elemento("botao_concluir_pagamento")
    end
  end

  def preenche_dois_cartoes_credito(bandeira = "master", parcela = 1)
    assert_selector(EL['botao_utilizar_dois_cartoes'], wait: 30)
    Common.new.clica_elemento('botao_utilizar_dois_cartoes')
    preenche_cartao_credito("cartao_um", 0, bandeira)
    all(EL["cartao_um"]['texto_qtd_parcelas'], wait: 30)[0].set(parcela)
    binding.pry
    find(EL["combo_forma_parcela"]).all('option')[1].click
    find('select[id="IdFormaPagamentoParcelamento"]').all('option')[1].click
    Common.new.clicar_inserir_valor("texto_cartao_dois", "4111111111111111")
    Common.new.seleciono_combobox_index("texto_val_mes_dois", 4)
    Common.new.seleciono_combobox_index("texto_val_ano_dois", 4)
    Common.new.clicar_inserir_valor("texto_nome_cartao_dois", "Teste Teste")
    Common.new.clicar_inserir_valor("texto_cvv_dois", "324")
    all(EL["cartao_dois"]['texto_qtd_parcelas'], wait: 30)[1].set(parcela)
    Common.new.clica_elemento("botao_concluir_pagamento")
  end

  def preencho_boleto_cartao(bandeira = "master", parcela = 1)
    assert_selector(EL['botao_utilizar_boleto_cartao'], wait: 30)
    Common.new.clica_elemento('botao_utilizar_boleto_cartao')
    preenche_cartao_credito("cartao_um", 0, bandeira)
    all(EL["cartao_um"]['texto_qtd_parcelas'], wait: 30)[0].set(parcela)
  end



  def preenche_cartao_credito(tipo_cartao,index = 0, tipo_dado)
    dados = CARTAO[:"#{tipo_dado}"]
    sleep(5)
    all(EL[tipo_cartao]['texto_num_cartao'], wait: 30)[index].set(dados[:numero])
    all(EL[tipo_cartao]['texto_nome_titular'], wait: 30)[index].set(dados[:nome])
    all(EL[tipo_cartao]['texto_val_ano'], wait: 30)[index].all(:option, dados[:dtValAno].to_i)[index].select_option
    all(EL[tipo_cartao]['texto_val_mes'], wait: 30)[index].all("option")[dados[:dtValMes].to_i].select_option
    all(EL[tipo_cartao]['texto_cvv'], wait: 30)[index].set(dados[:cvv]) if dados[:cvv] != ""
  end

  def seleciona_parcelas(qtd, tipo_cartao, index = 0)
    assert_no_selector('input[disabled="disabled"]', wait: 30, visible: true)
    sleep (1)
    all(EL[tipo_cartao]['texto_qtd_parcelas'], wait: 30)[index].set(qtd)
  end

end
