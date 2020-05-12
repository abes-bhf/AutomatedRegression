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
    email_field_v2(@@donate_email) #rndomly select emails 
    continue
  end

  def correct_address
    postcode_field_v2.send_keys "WR2 6NJ"
    address1_field_v2.send_keys "TEST"
    address2_field_v2.send_keys "TEST"
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





end
