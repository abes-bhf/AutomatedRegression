class GenericPage
  include RSpec::Matchers
  attr_accessor :browser

  def initialize(browser)
    @browser = browser
    @logo = browser.a(class: 'g-logo')
  end

  def find_logo
    @logo = browser.a(class: 'g-logo')
  end

  # def find_trait
  #   trait = @trait
  # end

  def visit
    TestBrowser.browser.goto @url
  end

  def click!(element)
    #scrolls to element and clicks
    Watir::Wait.until { element.exists? }
    element.scroll.to
    element.click
  end

  def continue
    # this is a work in progress! need an generic, airtight way of clicking the submit button
    # am not a huge fan of how i programmed it but its the most consistent way so far, yes I have tried using the ID, it changes
    # submit_buttons = browser.inputs(type: 'submit')
    # binding.pry
    # if submit_buttons.size ==  2
    #   @continue = submit_buttons[1].click!
    # else
    #   binding.pry
    # end
    @continue.click!
  end

  def on_page?
    begin
      find_logo
      @trait = trait
      #consider adding a URL check here
      Watir::Wait.until { @logo.exists? && @logo.present? }
      Watir::Wait.until { @trait.exists? && @trait.present? }
      return true
    rescue
      return false
    end
  end
end
