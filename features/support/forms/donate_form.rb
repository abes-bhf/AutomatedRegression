class DonateForm < GenericForm

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/donate/donate-form?page=1"
    @donationamount = browser.span(id: "main_0_pagecontent_0_donations2right_0_lblPieAmount")
    @continue = browser.input(value: 'Continue')
  end

  def trait
    trait = browser.h1(text: 'Your details')
    return trait
  end

  def fill_form(type)
    details = EnvConfig.data[type]['details']
    email = @@donate_email
    select_title(random_title)
    fill_name(details['fn'], details['ln'])
    fill_email(email)
    fill_telephone(details['tel'])
    fill_postcode(details['postcode'])
    manualaddressurl = browser.a(text: "or enter address manually")
    manualaddressurl.click!
    manual_address(details['address'])
    data_protection(details['dpemail'],details['dptext'],details['dppost'],details['dptel'])
    continue
  end

  def invalid_fill_form(type)
    select_title(random_title)
    fill_name("123", "@@@")
    fill_email("email@com")
    fill_telephone("phone")
    data_protection(false,false,false,false)
    manualaddressurl = browser.a(text: "or enter address manually")
    manualaddressurl.click!
    manual_address(EnvConfig.data["invalid_address"])
    continue
  end

end
