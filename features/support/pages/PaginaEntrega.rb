class PaginaEntrega
    include RSpec::Matchers
    include Capybara::DSL

  def seleciona_tipo_entrega(entrega,dados_endereco="sucesso")
    assert_selector(".fEntrega", text:"Normal",wait: 30, visible:true)
    endereco = ENDERECO[:dados_endereco]
    case entrega
      when "Expressa"
        if has_selector?(".grp.tEntrega.expressa.on") == true
          all(EL['radio_entrega'])[1].click
          Common.new.clica_elemento("botao_continuar_endereco")
        else
          raise "Forma de entrega Expressa nao esta disponivel para esse produto"
        end
      when "Retira"
        if has_selector?(".grp.tEntrega.pickup.on") == true
          all(EL['radio_entrega'])[2].click
          find(EL['estado_retira']).find('option', text: "SP").click
          find(EL['regiao_retira']).find('option', text: "Capital").click
          find(EL['cidade_retira']).find('option', text: "o Paulo").click
          find(EL['bairro_retira']).find('option', text: "Cambuci").click
          find(EL['loja_retira']).find('option', text: "Casas Bahia").click
          # assert_selector('.map', wait: 30)
          Common.new.clica_elemento("botao_continuar_endereco")
          # assert_selector('.map', wait: 30)
        else
          raise "Forma de entrega Retira nao esta disponivel para esse produto"
        end
      when "Agendada"
        if has_selector?(".grp.tEntrega.agendada.on") == true
          all(EL['radio_entrega'])[3].click
          find(EL['agenda_horario']).select("07:00 - 12:00")
          Common.new.clica_elemento("botao_continuar_endereco")
        else
          raise "Forma de entrega Retira nao esta disponivel para esse produto"
        end
    end
  end
end
