class Common
  include RSpec::Matchers
  include Capybara::DSL
  include FFaker

  def clicar_inserir_valor(campo, valor)
    assert_selector(EL[campo], wait: 30, visible:true)
    find(EL[campo], wait: 30).set(valor)
  end

  def clica_elemento(botao,index=0)
  assert_selector(EL[botao], wait: 30, visible:true)
  all(EL[botao], wait: 30)[index.to_i].click
  end

  def forma_entrega(forma)
  case forma
    when "Normal"
      assert_selector(".fEntrega", text:"Normal",wait: 30, visible:true)
      clica_elemento("botao_continuar_endereco")
    when "Retira"
      PaginaEntrega.new.seleciona_tipo_entrega("Retira","sucesso")
    when "Agendada"
      PaginaEntrega.new.seleciona_tipo_entrega("Agendada","sucesso")
    end
  end

  def seleciono_combobox_index(elemento, index = 0)
    assert_selector(EL[elemento], wait:10)
    find(EL[elemento]).all('option')[index.to_i].click
  end

end
