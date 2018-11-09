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

  def select_donation(type, amount)
    @oneofftab = browser.a(id: "main_0_pagecontent_0_donations1_0_lnkOneOff")
    @monthlytab = browser.a(id: "main_0_pagecontent_0_donations1_0_lnkRegular")
    @twenty = browser.span(class: 'amount', text: '£20')
    @ten = browser.span(class: 'amount', text: '£10')
    if type == "one-off"
      @oneofftab.scroll.to
      if amount == 20
        click!(@twenty)
        continue
      else
        pending
      end
    elsif type == "monthly"
      @monthlytab.click!
      if amount == 10
        @ten.click!
        continue
      end
    else
    end
  end



end
