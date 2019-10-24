class DonationPage < GenericPage

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/donate/donate-form"
    @continue = browser.input(id: 'main_0_pagecontent_0_donations1_0_uxSubmitBtn')
    @oneofftab = browser.a("data-ui-component": 'oneOffDonationTab')
    @monthlytab = browser.a("data-ui-component": 'regularDonationTab')
  end

  def trait
    trait = browser.div(class: 'donate-tabs')
    return trait
  end

  def select_donation(type)
    if type == "one-off"
      @oneofftab.scroll.to
      @oneofftab.click!
    elsif type =="monthly"
      @monthlytab.click!
      @monthlytab.scroll.to
    end
    #the following lines select a random preset donation amount displayed on the page
    presets = []
    browser.fieldset(class: 'donation-radio').ul.each do |preset|
      presets << preset
    end
    amount = presets.sample
    amount.span(class: 'amount').click!
    @@donation_amount = amount.text.split("\n")[0]
    continue
  end



end
