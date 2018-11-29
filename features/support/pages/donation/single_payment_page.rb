class SinglePaymentPage < GenericPage

  attr_accessor :url, :trait

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/donate/donate-form?page=2"
  end

  def trait
    trait = browser.div(class: 'payment-disclaimer')
    return trait
  end

  def select_worldpay
    worldpay_button = browser.input(id: "main_0_pagecontent_0_donations3_0_Button1")
    worldpay_button.click!
  end

  def select_paypal
    paypal_button = browser.input(id: "main_0_pagecontent_0_donations3_0_Button2")
    paypal_button.click!
  end

  def on_pg?
    @trait = browser.div(class: 'payment-disclaimer')
    on_page?
  end

end
