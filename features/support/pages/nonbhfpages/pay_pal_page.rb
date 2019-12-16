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
    email = browser.input(id: "email")
    password = browser.input(id: "password")
    loginbutton = browser.button(id: 'btnLogin')
    email.click
    email.send_keys(EnvConfig.data['paypal']['details']['em'])
    loginbutton.click!
    password.send_keys(EnvConfig.data['paypal']['details']['pw'])
    loginbutton.click!
    continue = browser.input(id: "confirmButtonTop")
    continue.click!
  end

  def cancel
    returnlink = browser.a(id: 'cancelLink')
    returnlink.click!
  end

end