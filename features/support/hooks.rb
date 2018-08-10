require 'selenium-webdriver'
# require 'report_builder'
# require_relative '../../data/data.yml'

Before do

  $EL = "EL_#{$site}"
  local = DATA["local"]
  local = local.gsub('bandeira', $site)
  visit(local)

end

#
Before do

  if File.exists?("./reports/new_report/ReportBuilder.json")
    File.delete("./reports/new_report/ReportBuilder.json")
  end

end

Before do |scn|

  Capybara.server_port = 8888 + ENV['TEST_ENV_NUMBER'].to_i
  $item_tipo = []

  @common = Common.new
  @paginaBusca = PaginaBusca.new
  @paginaGarantia = PaginaGarantia.new
  @paginaLogin = PaginaLogin.new
  @paginaPagamento = PaginaPagamento.new
  @assertPage = Assert_Page.new
  # @menu = PaginaMenu.new
  # @paginaInicial = PaginaInicial.new
  # @paginaRegistro = PaginaRegistro.new
  # @paginaProduto =  PaginaProduto.new
  # @paginaEntrega = PaginaEntrega.new
  # @paginaCarrinho = PaginaCarrinho.new
  # @paginaModal = PaginaModal.new
  # @paginaLojistas = PaginaLojistas.new
  # @paginaFinalizacao = PaginaFinalizacao.new
  # @paginaCadastro = PaginaCadastro.new
  # @paginaEndereco = PaginaEndereco.new

###################### reseta sessão
 Capybara.current_session.driver.browser.manage.delete_all_cookies
# page.driver.quit
# ##################### Resolução da tela
 Capybara.page.driver.browser.manage.window.maximize
 @scn_name = "#{scn.name + Time.now.strftime('%H-%M-%S-%L')}"

end


# Before do |step|
#   @data = "#{Time.now.strftime('%Y/%B/%d')}"
#   @hora = "#{Time.now.strftime('%H-%M-%S')}"
#   sleep 2
#   save_screenshot("data/screenshot/failed/#{@scn_name}/#{@data}#{@hora}.png")
# end
#
# After do |scn|
#   if scn.failed?
#     save_screenshot("data/screenshot/failed/#{@scn_name}/#{scn.__id__}.png")
#     embed("data/screenshot/failed/#{@scn_name}/#{scn.__id__}.png", "image/png", "SCREENSHOT")
#   end
# end

# After do |step|
#   sleep 2
#   save_screenshot("data/screenshot/#{@scn_name}/#{@data}#{@hora}.png")
#   if step.failed?
#     sleep 2
#     save_screenshot("data/screenshot/failed/#{@scn_name}/#{@data}#{@hora}.png")
#     embed("data/screenshot/failed/#{@scn_name}/#{@data}#{@hora}.png", "image/png", "Erro")
#   end
#
#  attach_file("Image", File.open("#{path}.png") )
# end

at_exit do
  ReportBuilder.configure do |config|
        config.json_path = 'reports/json'
        config.report_path = 'reports/new_report/ReportBuilderNew'
        config.report_types = [:html]
        config.report_tabs = [:overview, :features, :scenarios, :errors]
        config.report_title = 'Via Varejo Web Regressivo'
        config.compress_images = true
        config.additional_info = {browser: 'Chrome', environment: 'Stage 5'}
      end
      ReportBuilder.build_report
end
#
# After do |step|
#   if step.failed?
#     binding.pry
#   end
# end
