class MonthlyPaymentForm < GenericForm

  attr_accessor :url, :trait

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/donate/donate-form?page=2"
    @continue = browser.input(value: 'Continue')
  end

  def trait
    trait = browser.legend(text: 'Direct debit payment')
    return trait
  end

  def date_choices
    months_shown = []
    month_options = browser.select(id: 'main_0_pagecontent_0_donations3_0_ddlMonth').options
    month_options.each do |month|
      if Date::MONTHNAMES.include?(month.text)
        months_shown << month.text unless month == nil
      end
    end
    raise unless months_shown.size > 5
  end

  def dd_start_date(day, month)
    ddmonth = browser.select(id: 'main_0_pagecontent_0_donations3_0_ddlMonth')
    dropdownselect(ddmonth, month)
    if day == 1
      start = browser.input(value: 'rbDonationFirst')
    elsif day == 15
      start = browser.input(value: 'rbDonationSecond')
    else
      pending
    end
    start.scroll.to
    # binding.pry
    start.click!
  end

  def fill_account_details
    if Date.today.month == 12
      date = "January"
    else
      date = Date::MONTHNAMES[Date.today.month + 1]
    end
    dd_start_date(1, date)
    accname = browser.input("data-ui-component": 'ddNameAccountHolder')
    sendkeys!(accname, 'Auto Monthly')
    accno = browser.input("data-ui-component": 'ddAccountNumber')
    sendkeys!(accno, '38290008')
    sc1 = browser.input("data-ui-component": 'ddSortCode1')
    sendkeys!(sc1, '20')
    sc2 = browser.input("data-ui-component": 'ddSortCode2')
    sendkeys!(sc2, '04')
    sc3 = browser.input("data-ui-component": 'ddSortCode3')
    sendkeys!(sc3, '15')
    bank = browser.input("data-ui-component": 'ddNameBankBuildingSociety')
    sendkeys!(bank, 'Auto Bank')
    browser.input(id: 'main_0_pagecontent_0_donations3_0_btnSubmitDD').click!
  end

end
