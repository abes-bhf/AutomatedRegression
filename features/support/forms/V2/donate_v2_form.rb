class DonateV2Form < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/donate/donation/get-started"
    @continue = browser.button(text: "Continue")
  end

  def donate_widget_monthly
    browser.input(value: '£10').click #need to change code to raffle select amount
    continue
  end

  def correct_about_you
    dropdown_select
    sleep 4
    firstname_field_v2.send_keys "AutomatedFN"
    lastname_field_v2.send_keys "AutomatedLN"
    email_field_v2.send_keys(@@donate_email) #rndomly select emails
    continue
  end

  def correct_address
    postcode_field_v2.send_keys "WR2 6NJ"
    address1_field_v2.send_keys "Automated Test"
    address2_field_v2.send_keys "Automated Test"
    city_field_v2.send_keys "LONDON"
    continue
  end

  def isthisyourmoney
    isthisyourmoney = browser.input(value: "IsMyOwnMoney").click
    continue
  end

  def termsandcondition
    termsandcondition = browser.div(class: "f-forms__checkbox")
  end
  def add_giftaid
    add_giftaid = browser.input(value: "Yes").click
    termsandcondition.scroll.to :center
    sleep 1
    termsandcondition.click
    continue
  end

  #direct debit deets
  def direct_debit_date
    direct_debit_date = browser.input(value: "1").click
  end

  def account_holder_name
    account_holder_name = browser.input(name: "AccountHolderName")
    return account_holder_name
  end

  def account_number
    account_number = browser.input(name: "BankAccountNumber")
    return account_number
  end

  def sort_code
    sort_code = browser.input(name: "SortCode")
    return sort_code
  end

  def bank_name
    bank_name = browser.input(name: "BankName")
    return bank_name
  end

  #actually inputting bank details

  def direct_debit
    direct_debit_date
    account_holder_name.send_keys "Fiyona Testing"
    account_number.send_keys "38290008"
    sort_code.send_keys "200415" #make it scroll down here or somthing
    bank_name.send_keys "Fake Bank"
    contnue
  end



end
