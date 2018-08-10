class PaginaBusca

  include RSpec::Matchers
  include Capybara::DSL

  def seleciona_produto(produto, index)
    assert_selector('.productImage', wait: 30)
    case produto
      when "notebook"
        nome = ".name.fn"
        assert_selector(nome, wait: 30)
        valor = all(nome)[0].text
        if valor.include? "Notebook"
          all(nome, text: valor)[0].click
        else
          raise "#{valor} nao corresponde a pesquisa "
        end
      when "notebook_retira"
        assert_selector('.productImage', wait: 30)
      end
    end
  end
