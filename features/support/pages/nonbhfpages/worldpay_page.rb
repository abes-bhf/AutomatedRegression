class WorldpayPage < GenericForm
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
    browser.text_field(id: "cardNumber").send_keys('4444333322221111')
    expmonth = browser.text_field(id: "expiryMonth")
    expyear = browser.text_field(id: "expiryYear")
    sendkeys!(expmonth, '01')
    sendkeys!(expyear, "#{(Time.now.year + 1)%100}")
    browser.text_field(id: "securityCode").send_keys('123')
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
