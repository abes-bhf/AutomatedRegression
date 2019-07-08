
require 'rspec'
require 'watir'
require 'pry'
require 'fileutils'
require 'rspec/expectations'
require 'watir-scroll'
require 'page-object'


#
# BROWSER = Watir::Browser.start(:chrome)
# class App < Watir::Browser
#   def initialize(browser)
#     @browser = browser
#   end
# end
#
# class TestSite < App
#   def BHF_Homepage
#     @bhf_homepage = BHF_Homepage.new(@browser)
#   end
#
#   def close
#     @browser.close
#   end
# end
# #
require File.dirname(__FILE__) + '/pages/generic_page.rb'
require File.dirname(__FILE__) + '/forms/generic_form.rb'
Dir[File.dirname(__FILE__) + '/pages/*.rb'].each { |f| require f}
Dir[File.dirname(__FILE__) + '/forms/*.rb'].each { |f| require f}
Dir[File.dirname(__FILE__) + '/../../lib/*.rb'].each { |f| require f }

  PAGES = {
  "BHF Home" => "https://bhf.org.uk"}
