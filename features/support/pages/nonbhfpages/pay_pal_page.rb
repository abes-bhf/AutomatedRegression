class PayPalPage < GenericPage
  include RSpec::Matchers
  attr_accessor :browser, :trait

  def initialize(browser)
    @browser = browser
  end

  def trait
    trait = browser.div(id: 'paypalLogo')
    return trait
  end

  def login
    # loginbutton = browser.a(text: 'Log In')
    email = browser.text_field(id: "email")
    password = browser.text_field(id: "password")
    loginbutton = browser.button(id: 'btnLogin')
    email.click
    email.send_keys(EnvConfig.data['paypal']['details']['em'])
    loginbutton.click!
    password.send_keys(EnvConfig.data['paypal']['details']['pw'])
    loginbutton.click!
    continue = browser.button(id: "payment-submit-btn")
    trait2 = browser.p(text: "Chris Thorn")
    begin
      retries ||= 0
      Watir::Wait.until { trait2.exists? && trait2.present? }
    rescue
      retry if (retries += 1) < 3
    end
    continue.click!
  end

  def cancel
    returnlink = browser.a(id: 'cancelLink')
    returnlink.click!
  end

end
