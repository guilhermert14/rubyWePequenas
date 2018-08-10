class Assert_Page

 include RSpec::Matchers
 include Capybara::DSL

 def valida_url(url)
  if page.driver.current_url.include? url
    p "Pagina correta #{page.driver.current_url}"
  elsif page.driver.current_url.downcase.include? url
    p "Pagina correta #{page.driver.current_url}"
  else
    raise "Página incorreta #{page.driver.current_url}"
  end
end

def valida_existencia_elemento(elemento)
   if assert_selector(elemento, wait:20)
     p "Elemento (#{elemento}) localizado com sucesso na página"
   else
     raise "Elemento (#{elemento}) não foi localizado na página"
   end
  end

end
