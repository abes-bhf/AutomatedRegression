class DonationPage < GenericPage

  attr_accessor :url, :trait

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/donate/donate-form"
    @continue = browser.input(id: 'main_0_pagecontent_0_donations1_0_uxSubmitBtn')
  end

  def trait
    trait = browser.div(class: 'donate-tabs')
    return trait
  end

  def select_donation(type)
    #selects a random preset donation amount displayed on the page
    @oneofftab = browser.a(id: "main_0_pagecontent_0_donations1_0_lnkOneOff")
    @monthlytab = browser.a(id: "main_0_pagecontent_0_donations1_0_lnkRegular")
    if type == "one-off"
      @oneofftab.scroll.to
    elsif type =="monthly"
      @monthlytab.click!
    end
    presets = []
    browser.fieldset(class: 'donation-radio').ul.each do |preset|
      presets << preset.span(class: 'amount')
    end
    presets.sample.click!
    continue
  end



end
