class WorldpayPage < GenericPage
  include RSpec::Matchers
  attr_accessor :browser, :trait

  def initialize(browser)
    @browser = browser
  end

  def trait
    trait = browser.image(alt: 'Worldpay')
    return trait
  end

  def use_valid_card
    visa = browser.img(title: "VISA")
    visa.click!
    browser.input(id: "cardNumber").send_keys('4444333322221111')
    expmonth = browser.select(id: "expiryMonth")
    expyear = browser.select(id: "expiryYear")
    dropdownselect(expmonth, '01')
    dropdownselect(expyear, "#{Time.now.year + 1}")
    browser.input(id: "securityCode").send_keys('123')
    browser.input(id: "submitButton").click!
  end

  def dropdownselect(dropdown, selection)
    #takes a 'select' type html element as an argument and looks for the string provided as argument 1
    #copy of the exact same method from generic_form.rb! consider placing this method somewhere accessible to both this and that class
    dropdown.scroll.to
    dropdown.options.each do |option|
      if option.text == selection
        option.click
      end
    end
    raise unless dropdown.text == selection
  end

  def cancel
    cancelbutton = browser.a(id: "cancelButton")
    yescancel = browser.a(id: "exitPaymentYesJsOff")
    cancelbutton.click!
    yescancel.click!
  end

end
