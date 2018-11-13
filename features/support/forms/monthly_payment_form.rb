class MonthlyPaymentForm < GenericForm

  attr_accessor :url, :trait

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/donate/donate-form?page=2"
    @continue = browser.input(id: 'main_0_pagecontent_0_donations3_0_btnSubmitDD')
  end

  def trait
    trait = browser.legend(text: 'Direct debit payment')
    return trait
  end

  def dd_start_date(day, month)
    ddmonth = browser.select(id: 'main_0_pagecontent_0_donations3_0_ddlMonth')
    if day == 1
      start = browser.radio(value: 'rbDonationFirst')
    elsif day == 15
      start = browser.radio(value: 'rbDonationSecond')
    else
      pending
    end
    dropdownselect(ddmonth, month)
    start.scroll.to
    start.set
  end

  def fill_account_details
    if Date.today.month == 12
      date = "January"
    else
      date = Date::MONTHNAMES[Date.today.month + 1]
    end
    dd_start_date(1, date)
    accname = browser.input(id: 'main_0_pagecontent_0_donations3_0_txtDDNameAccountHolder')
    sendkeys!(accname, 'Auto Monthly')
    accno = browser.input(id: 'main_0_pagecontent_0_donations3_0_txtDDAccountNumber')
    sendkeys!(accno, '38290008')
    sc1 = browser.input(id: 'main_0_pagecontent_0_donations3_0_txtDDSortCodeOne')
    sendkeys!(sc1, '20')
    sc2 = browser.input(id: 'main_0_pagecontent_0_donations3_0_txtDDSortCodeTwo')
    sendkeys!(sc2, '04')
    sc3 = browser.input(id: 'main_0_pagecontent_0_donations3_0_txtDDSortCodeThree')
    sendkeys!(sc3, '15')
    bank = browser.input(id: 'main_0_pagecontent_0_donations3_0_txtDDNameBankBuildingSociety')
    sendkeys!(bank, 'Auto Bank')
    browser.input(id: 'main_0_pagecontent_0_donations3_0_btnSubmitDD').click!
  end

end
