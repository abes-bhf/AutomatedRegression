class LondonToBrightonRegistration1 < GenericForm

  def initialize(browser)
    super
    @continue = browser.input(id: "main_0_pagecontent_0_form_7A686591743F4EC0B53503C4317F3936_form_7A686591743F4EC0B53503C4317F3936_submit")
  end

  def trait
    trait = browser.h2(text: 'London to Brighton Bike Ride 2020')
    return trait
  end

  def email_recognised?
    emailabel = browser.div(id: "main_0_pagecontent_0_form_7A686591743F4EC0B53503C4317F3936_field_D4C11CA3D79048BBAD57E421EB9E50D5_scope")
    accmatched = browser.p(id: 'accMatched')
    browser.a(text: 'Search').click!
    browser.div(class: ["g-screen", "active"]).click
    emailabel.scroll.to
    begin
      Watir::Wait.until { accmatched.present? }
      return true
    rescue
      return false
    end
  end

  def fill_details
    select_title(random_title)
    date_of_birth("#{Time.now.day}", "#{Time.now.month}", "#{Time.now.year - 20}")
    fill_name1('Auto LTB FN', 'Auto LTB LN')
    # fill_new_email unless browser.div(class: 'name.emailaddress').input.value != ""
    postcode_lookup('NW22PX')
    fill_telephone('0987612345')
    data_protection(false, false, false, false)
    continue
  end

  def login_now
    raise("Email not recognised") unless email_recognised?
    login = browser.p(id: 'accMatched').a(text: "login now")
    login.click!
  end

  def prepopulated_submission
    #BAFFLED! Why is the the id for the continue button changing?????
    date_of_birth("#{Time.now.day}", "#{Time.now.month}", "#{Time.now.year - 20}")
    data_protection(false, false, false, false)
    browser.input(id: "main_0_pagecontent_0_form_1EBC23CD86B440E193CE24BF725DA7C3_form_1EBC23CD86B440E193CE24BF725DA7C3_submit").click!
  end

end
