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
    loginbutton = browser.a(text: 'Log In')
    nextbutton = browser.button(id: 'btnNext')
    loginbutton2 = browser.button(id: 'btnLogin')
    loginbutton.click!
    email = browser.input(id: "email")
    email.click
    email.send_keys(EnvConfig.data['paypal']['details']['em'])
    nextbutton.click!
    password = browser.input(id: "password")
    password.send_keys(EnvConfig.data['paypal']['details']['pw'])
    loginbutton2.click!
    continue = browser.input(id: "confirmButtonTop")
    continue.click!
  end

  def cancel
    returnlink = browser.a(id: 'cancelLink')
    returnlink.click!
  end

end
