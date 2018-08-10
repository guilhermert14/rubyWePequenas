Dado(/^preencho minha identificacao com usuario "([^"]*)"$/) do |usuario|
  dados = LOGIN[:"#{usuario}"]
  @paginaLogin.login(dados[:email],dados[:senha])
end
