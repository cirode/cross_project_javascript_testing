require 'rubygems'
require 'rspec'
require "selenium-webdriver"

module BrowserHelper
  def for_each_browser(browser_names=[:chrome, :firefox], &block)
    browser_names.each do |browser_name|
      driver = Selenium::WebDriver.for browser_name
      block.call(driver, browser_name)
      at_exit do 
        driver.quit
      end
    end
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    #some sort of setup here. Make sure we can connect to teh testable version of the app etc
  end
  
  config.before(:each) do
    #we will need to create data etc to work properly, else the suite will atke forever to run
  end
  
  config.after(:suite) do
  end
end
