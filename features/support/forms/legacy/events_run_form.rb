class EventsRunForm < GenericForm

  def initialize(browser)
    super
    @continue = browser.input(Value: "Submit")
  end

  def trait
    trait = browser.h2(text: 'Event specific questions')
    return trait
  end
  #
  def fill_details_p2
    # values = EnvConfig.data['radios']
    answers = EnvConfig.data['event_specific_answers']
    selects = []
    browser.selects.each do |o|
      if o.present?
        selects << o
      end
    end
    selects.each do |p|
      p.options[1].click
    end
    fundraising_target = browser.text_field(id: 'uxa496e56d-38e6-41b6-a4e9-1fb77eb94317')
    browser.input(id: "uxcdab56b5-af9a-4170-bce1-cd03f104f590").send_keys "Test"
    terms_and_conditions = browser.checkbox(id: 'main_0_pagecontent_0_eventreg2_0_chkTandCs')
    browser.input(id: "ux50d38c98-5a79-4ecd-af0e-7160d7ffe898").send_keys "Test"
    sendkeys!(fundraising_target, answers['fundraising_target'])
    terms_and_conditions.scroll.to
    terms_and_conditions.click!
    browser.input(value: "Continue").click!
  end

  def fill_details
    select_title(random_title)
    date_of_birth("#{Time.now.day}", "#{Time.now.month}", "#{Time.now.year - 20}")
    fill_name1('Auto LTB FN', 'Auto LTB LN')
      # fill_new_email unless browser.div(class: 'name.emailaddress').text_field.value != ""
    postcode_lookup('NW22PX')
    fill_telephone('0987612345')
    data_protection(false, false, false, false)
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

  def new_registration
    fill_details
    browser.input(id: 'main_0_pagecontent_0_form_7A686591743F4EC0B53503C4317F3936_field_D4C11CA3D79048BBAD57E421EB9E50D5').send_keys [@@new_acc_email, :tab]
    password = browser.text_field(id: "main_0_pagecontent_0_form_7A686591743F4EC0B53503C4317F3936_field_C1C7AC7FC92441598E7D657AF0DCD6B9border_field_C1C7AC7FC92441598E7D657AF0DCD6B9")
    confirmpassword = browser.text_field(id: "main_0_pagecontent_0_form_7A686591743F4EC0B53503C4317F3936_field_C1C7AC7FC92441598E7D657AF0DCD6B9border_confirmation")
    sendkeys!(password, "Pa55w0rd")
    sendkeys!(confirmpassword, "Pa55w0rd")
    continue
  end

end
