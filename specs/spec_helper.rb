require 'rubygems'
require 'rspec'
require "selenium-webdriver"
require 'lazy'

module BrowserHelper
  def for_each_browser(browser_names=[:firefox, :chrome], &block)
    previous_browser = nil
    at_exit do
      previous_browser.quit if previous_browser
    end
    browser_names.each do |browser_name|
      driver =  Lazy::Promise.new do 
        previous_browser.quit if previous_browser
        previous_browser = Selenium::WebDriver.for( *(respond_to?(method_name = "#{browser_name}_instance") ? send(method_name) :  [browser_name]))
      end
      block.call(driver, browser_name)
    end
  end
  
  def ie_instance
    [:remote, {:url => 'http://10.211.55.6:4444/wd/hub', :desired_capabilities => :ie}]
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
