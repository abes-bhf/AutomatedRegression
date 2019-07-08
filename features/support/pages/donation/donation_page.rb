class DonationPage < GenericPage

  attr_accessor :url, :trait

  page_url(EnvConfig.base_url + "how-you-can-help/donate/donate-form")
  div(:pom_trait, :class => 'donate-tabs')

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/donate/donate-form"
    @continue = browser.input(id: 'main_0_pagecontent_0_donations1_0_uxSubmitBtn')
  end

  def trait
    # trait = browser.div(class: 'donate-tabs')
    # return trait
    binding.pry
    return pom_trait_element
  end

  def select_donation(type)
    #selects a random preset donation amount displayed on the page
    @oneofftab = browser.a("data-ui-component": 'oneOffDonationTab')
    @monthlytab = browser.a("data-ui-component": 'regularDonationTab')
    if type == "one-off"
      @oneofftab.scroll.to
    elsif type =="monthly"
      @monthlytab.click!
      @monthlytab.scroll.to
    end
    presets = []
    browser.fieldset(class: 'donation-radio').ul.each do |preset|
      presets << preset
    end
    presets.sample.span(class: 'amount').click!
    continue
  end



end
