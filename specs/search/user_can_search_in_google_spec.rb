require File.join(File.dirname(__FILE__),'..','spec_helper')
include BrowserHelper

for_each_browser do |driver, driver_name|
  describe "searching in #{driver_name}" do
    context "when on the root path" do
      before do
        driver.get 'http://google.com'
      end
    
      it "should have the google logo with a title Google" do
        driver.find_element(:id => 'hplogo', :title => "Google").should_not be_nil
      end
    
      it "should have a search box" do
        driver.find_element(:name => 'q', :title => "Search").should_not be_nil
      end
    
      context "and the user searches for puppies" do
        before do
          driver.find_element(:name => 'q').send_keys "Puppies"
          wait = Selenium::WebDriver::Wait.new(:timeout => 2) # seconds
          @results_element = nil
          wait.until { @results_element = driver.find_element(:id => "ires") }
          @results_element
        end
      
        it "should automatically show results" do
          @results_element.find_elements(:class => 'g').should_not be_empty
        end
      
        it "should show the Everything navigation item selected" do
          nav = driver.find_element(:id => 'leftnav')
          nav.find_element(:class => 'msel').text.should == "Everything"
        end
      end
    end
  end
end