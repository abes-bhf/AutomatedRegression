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

  def login_button
    loginbutton = browser.ul(class: 'g-nav-primary__top').a(text: 'LOG IN/REGISTER')
    return loginbutton
  end

  def logout_button
    logoutbutton = browser.ul(class: 'g-nav-primary__top').a(text: 'SIGN OUT')
    return logoutbutton
  end

  def log_out
    loginbutton = login_button
    if loginbutton.present? == false
      logoutbutton = logout_button
      logoutbutton.click!
    else
      raise('no logout button found, are you already logged out?')
    end
  end

  def log_in
    logoutbutton = logout_button
    if logoutbutton.present? == false
      loginbutton = login_button
      loginbutton.click!
    else
      raise('no login button found, are you already logged in?')
    end
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
