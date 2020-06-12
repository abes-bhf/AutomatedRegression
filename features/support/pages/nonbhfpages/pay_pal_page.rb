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
    overlay = browser.div(class: "SpinnerOverlay_SpinnerOverlay_3KudG")
    begin
      retries ||= 0
      Watir::Wait.until { continue.exists? && continue.present? }
      continue.click!
      Watir::Wait.until { overlay.exists? && overlay.present? }
    rescue
      retry if (retries += 1) < 3
    end
  end

  def cancel
    returnlink = browser.a(id: 'cancelLink')
    returnlink.click!
  end

end
