class EventPaymentPage < GenericPage

  attr_accessor :url, :trait

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/events/bike-rides/london-to-brighton-bike-ride-2020/individual-registration?page=3"
  end

  def trait
    trait = browser.h1(text: 'Review')
    return trait
  end

  def select_worldpay
    worldpay_button = browser.input(id: "main_0_pagecontent_0_eventreg3_0_uxSubmitBtn")
    worldpay_button.click!
  end

  def select_paypal
    paypal_button = browser.input(id: "main_0_pagecontent_0_eventreg3_0_Button2")
    paypal_button.click!
  end

end
