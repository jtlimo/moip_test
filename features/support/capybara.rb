    Capybara.register_driver :chrome do |app|
        caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => [ "--start-maximized" ]})
	    Capybara::Selenium::Driver.new(app, {:browser => :chrome, :desired_capabilities => caps})
    end
    Capybara.default_driver = :chrome
    Capybara.default_max_wait_time = 10
    Capybara.javascript_driver = :webkit
    Capybara.page.driver.browser.manage.window.maximize
