class ContactUsConfirmation < GenericForm

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "what-we-do/contact-us/thank-you-contact-us"
    @continue = browser.input(value: "Submit")
  end

  def trait
    trait = browser.div(id: 'main_0_pagecontent_0_middlecontent_0_form_F76DDE83AF99444382BAA25611431FF2_fieldContainer')
    return trait
  end

end
