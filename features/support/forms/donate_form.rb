class DonateForm < GenericForm

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/donate/donate-form?page=1"
    @donationamount = browser.span(id: "main_0_pagecontent_0_donations2right_0_lblPieAmount")
    @continue = browser.input( id: "main_0_pagecontent_0_form_8E055C52ADC344FFB848479DB2A001D7_form_8E055C52ADC344FFB848479DB2A001D7_submit")
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
    postcode_lookup(details['postcode'])
    data_protection(details['dpemail'],details['dptext'],details['dppost'],details['dptel'])
    continue
  end

end
