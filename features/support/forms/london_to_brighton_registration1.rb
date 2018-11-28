class LondonToBrightonRegistration1 < GenericForm

  def initialize(browser)
    super
    @continue = browser.input(id: "main_0_pagecontent_0_form_7A686591743F4EC0B53503C4317F3936_form_7A686591743F4EC0B53503C4317F3936_submit")
  end

  def trait
    trait = browser.h2(text: 'London to Brighton Bike Ride 2019')
    return trait
  end

  def email_recognised?
    browser.label(text: 'Email address*').click
    accmatched = browser.p(id: 'accMatched')
    begin
      Watir::Wait.until { accmatched.present? }
      return true
    rescue
      return false
    end
  end

  def fill_details
    registration_options = browser.table(id: 'main_0_pagecontent_0_form_7A686591743F4EC0B53503C4317F3936_field_80D9C8C678534677B53612665DAFE18Fscope')
    registration_options.scroll.to
    registration_options.radio(value: '{61C70174-5180-48D2-A0E9-2A5C487B0A3D}').set
    select_title(random_title)
    date_of_birth("#{Time.now.day}", "#{Time.now.month}", "#{Time.now.year - 20}")
    fill_name1('Auto LTB FN', 'Auto LTB LN')
    fill_new_email unless browser.div(class: 'name.emailaddress').input.value != ""
    postcode_lookup('NW22PX')
    fill_telephone('0987612345')
    data_protection(false, false, false, false)
    continue
  end

  def login_now
    browser.p(id: 'accMatched').a(text: "login now").click
  end

  def prepopulated_submission
    #BAFFLED! Why is the the id for the continue button changing?????
    registration_options = browser.table(id: 'main_0_pagecontent_0_form_1EBC23CD86B440E193CE24BF725DA7C3_field_678A651E138B4CAD97A46031115225EAscope')
    registration_options.scroll.to
    registration_options.radio(value: '{61C70174-5180-48D2-A0E9-2A5C487B0A3D}').set
    date_of_birth("#{Time.now.day}", "#{Time.now.month}", "#{Time.now.year - 20}")
    data_protection(false, false, false, false)
    browser.input(id: "main_0_pagecontent_0_form_1EBC23CD86B440E193CE24BF725DA7C3_form_1EBC23CD86B440E193CE24BF725DA7C3_submit").click!
  end

end
