class PaginaGarantia

  include RSpec::Matchers
  include Capybara::DSL

  def seleciona_garantia(tipo_garantia)
    if has_selector(EL['campo_garantia']) == true
      case tipo_garantia
        when "12_meses"
          all(EL['radio_garantia'], wait: 5)[0].click
        when "24_meses"
          all(EL['radio_garantia'], wait: 5)[1].click
        when "36_meses"
          all(EL['radio_garantia'], wait: 5)[2].click
      end
    end

  end

  def continua_garantia
    if has_selector?(EL['campo_garantia']) == true
      Common.new.clica_elemento("botao_recusar_garantia",1)
    end

  end
end
