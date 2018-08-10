Entao(/^valido a url de finalizacao da compra$/) do
  2.times{
    has_selector?("#blockMsg") == true
    assert_selector("#blockMsg", wait:30, visible:false)
  }
  sleep (2)
  url = DATA["finalizacao"]
  url = url.gsub('bandeira', $site)
  page.driver.browser.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoAlertOpenError
  @assertPage.valida_url(url)
end
