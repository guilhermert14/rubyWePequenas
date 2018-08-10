require 'rspec'
require 'capybara/cucumber'
require 'pry'
require 'yaml'
require 'capybara/poltergeist'
require 'ffaker'
require 'selenium/webdriver'
require 'rest-client'
require 'uri'

DATA = YAML.load_file('data/data.yml')
EL = YAML.load_file('data/elements.yml')
MSG = YAML.load_file('data/messages.yml')

if ENV['lojahp']
  $site = "lojahp"
else ENV['barateiro']
  $site = "barateiro"
end

if ENV['209']
   $proxy = '10.128.132.209'
 elsif ENV['28']
   $proxy = '10.128.132.28'
 else
   $proxy =  ''
 end

 Capybara.default_max_wait_time = 35
if ENV['chrome']
 Capybara.default_driver = :chrome
 caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["--proxy-server=#{$proxy}","--ignore-certificate-errors"]})
 caps['pageLoadStrategy'] = 'none'
 Capybara.register_driver :chrome do |app|
   Capybara::Selenium::Driver.new(app, :detach => false, :browser => :chrome, :desired_capabilities => caps)
  end
elsif ENV['chrome_headless']
Capybara.default_driver = :chrome_headless
Capybara.register_driver :chrome_headless do |app|
 Capybara::Selenium::Driver.new(app,
                                browser: :chrome,
                                switches: ['--incognito',
                                           '--headless',
                                           'disable-gpu',
                                           'window-size=1280x720'])
end
elsif ENV['firefox']
  Capybara.default_driver = :firefox
  Capybara.register_driver :firefox do |app|
    Capybara::Selenium::Driver.new(app, browser: :firefox)
  end
elsif ENV['remote_headless']
 capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
   "chromeOptions" => {"args" => ["--fast","--no-default-browser-check","pageLoadStrategy=none","--no-sandbox","--headless","disable-gpu","window-size=1280x720","--proxy-server=#{$proxy}"]})
 capabilities['browserName'] = "chrome"
 capabilities['platform'] = "WINDOWS"
 capabilities['pageLoadStrategy'] = 'none'
 Capybara.default_driver = :chrome_headless
 Capybara.register_driver :chrome_headless do |app|
 Capybara::Selenium::Driver.new(app,
                                 browser: :chrome,
                                 url: "http://10.128.132.161:4381/wd/hub",
                                 desired_capabilities: capabilities
                               )
 end
elsif ENV['iphone']
 iphone6 = 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1'
 Capybara.default_driver = :chrome
 Capybara.register_driver :chrome do |app|
   caps = Selenium::WebDriver::Remote::Capabilities.chrome
   caps['pageLoadStrategy'] = 'none'
   Capybara::Selenium::Driver.new(app,
                                  browser: :chrome,
                                  port: 4442,
                                  desired_capabilities: caps,
                                  switches: [ '--window-size=360,640',
                                              "--user-agent='#{iphone6}'"
                                  ])
 end
else ENV['remote']
   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["--proxy-server=#{$proxy}"]})
   capabilities['browserName'] = "chrome"
   capabilities['platform'] = "WINDOWS"
   capabilities['pageLoadStrategy'] = 'none'
 Capybara.register_driver :selenium do |app|
   client = Selenium::WebDriver::Remote::Http::Default.new
   client.read_timeout= 1200 #seconds
   Capybara::Selenium::Driver.new(app, http_client: client,
     :browser => :remote,
     :url => "http://10.128.132.161:4381/wd/hub",
     :desired_capabilities => capabilities
       )
 end

 Capybara.default_driver = :selenium
 Capybara.javascript_driver = :poltergeist
 Capybara.run_server = false

end
