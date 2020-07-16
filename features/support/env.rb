require 'rspec'
require 'watir'
require 'pry'
require 'fileutils'
require 'rspec/expectations'
require 'watir-scroll'
require 'page-object'


require File.dirname(__FILE__) + '/pages/generic_page.rb'
require File.dirname(__FILE__) + '/forms/legacy/generic_form.rb'
require File.dirname(__FILE__) + '/forms/v2/generic_v2_form.rb'
Dir[File.dirname(__FILE__) + '/pages/**/*.rb'].each { |f| require f}
Dir[File.dirname(__FILE__) + '/forms/**/*.rb'].each { |f| require f}
Dir[File.dirname(__FILE__) + '/../../lib/*.rb'].each { |f| require f }

  PAGES = {
  "BHF Home" => "https://bhf.org.uk"}
