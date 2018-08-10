Dado(/^adiciono um produto "([^"]*)" no carrinho$/) do |tipo|

  @common.clicar_inserir_valor("texto_buscar", tipo)
  @common.clica_elemento("botao_buscar")
  @paginaBusca.seleciona_produto(tipo, 1)
  @common.clica_elemento("botao_adicionar")
  
end
