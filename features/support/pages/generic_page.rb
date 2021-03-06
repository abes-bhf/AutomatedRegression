class GenericPage
  include RSpec::Matchers
  include PageObject
  attr_accessor :browser


  def initialize(browser)
    @browser = browser
    @logo = browser.a(class: 'g-logo')
    @trait = ''
  end

  def find_logo
    @logo = browser.a(class: 'g-logo')
  end

  # def find_trait
  #   trait = @trait
  # end

  def visit
    begin
      counts ||= 0
      TestBrowser.browser.goto @url
    rescue
      retry if (counts += 1) < 5
    end
    if @@ENV == "gateway"
      if browser.button(id:"details-button").present?
        browser.button(id:"details-button").click
        browser.a(id: "proceed-link").click
      end
    end
    if @@cookiecount < 1
      @@cookiebutton = browser.button(id: "onetrust-accept-btn-handler")
      Watir::Wait.until {@@cookiebutton.present? && @@cookiebutton.exists?}
        begin
          retries ||= 0
          @@cookiebutton.click
        rescue Selenium::WebDriver::Error::ElementClickInterceptedError
          retry if (retries += 1) < 3
        end
        @@cookiecount = 1
    end
  end

    # sleep(2)
    # if browser.button(id: "onetrust-accept-btn-handler").present?
    #   begin
    #     retries ||= 0
    #     browser.button(id: "onetrust-accept-btn-handler").click
    #   rescue Selenium::WebDriver::Error::ElementClickInterceptedError
    #     retry if (retries += 1) < 3
    #   end
    # end





  def login_button
    loginbutton = browser.ul(class: 'g-nav-primary__top').a(text: 'LOG IN/REGISTER')
    return loginbutton
  end

  def logout_button
    logoutbutton = browser.ul(class: 'g-nav-primary__top').a(text: 'SIGN OUT')
    return logoutbutton
  end

  def log_out
    begin
      retries ||= 0
      loginbutton = login_button
      if loginbutton.present? == false
        logoutbutton = logout_button
        logoutbutton.click!
      else
        raise('no logout button found, are you already logged out?')
      end
    rescue
      sleep(1)
      retry if (retries += 1) < 3
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
    click_retries = 0
    begin
      element.click
    rescue
      retry if (click_retries += 1) < 4
    end
  end

  def continue
    # this is a work in progress! need an generic, airtight way of clicking the submit button
    # am not a huge fan of how i programmed it but its the most consistent way so far, yes I have tried using the ID, it changes
    # submit_buttons = browser.text_fields(type: 'submit')
    # binding.pry
    # if submit_buttons.size ==  2
    #   @continue = submit_buttons[1].click!
    # else
    #   binding.pry
    # end
    @continue.click!
  end

  def sendkeys!(textfield, text)
    # takes an text_field html element as the 1st argument, scrolls to it then fills it with the keys provided in the second argument)
    textfield.scroll.to
    textfield.set(text)
  end

  def on_page?
    op_count = 0
    begin
      find_logo
      @trait = trait
      #consider adding a URL check here
      Watir::Wait.until { @logo.exists? && @logo.present? }
      Watir::Wait.until { @trait.exists? && @trait.present? }
      return true
    rescue
      retry if (op_count += 1) < 3
      return false
    end
  end

end
