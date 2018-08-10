class PaginaLogin
  include RSpec::Matchers
  include Capybara::DSL

  def login(email, senha)
    assert_selector(EL['texto_email'], wait: 30, visible:true)
    find(EL['texto_email'], wait: 30).set(email)
    find(EL['texto_senha'], wait: 30).set(senha)
    Common.new.clica_elemento("botao_continuar_login")
  end

end
