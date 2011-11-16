require 'rubygems'
require 'rspec'
require "selenium-webdriver"

RSpec.configure do |config|
  config.before(:suite) do
    #some sort of setup here. Make sure we can connect to teh testable version of the app etc
  end
  
  config.before(:each) do
    #we will need to create data etc to work properly, else the suite will atke forever to run
  end
  
  config.after(:each) do
    driver.quit
  end
end
