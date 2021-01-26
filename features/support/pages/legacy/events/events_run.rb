class EventsRunPage < GenericPage

  attr_accessor :url, :trait

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/events/runs/kew-gardens-10k---bhf-charity-place/individual-registration?page=1"
  end

  def trait
    trait = browser.h1(text: 'My Account')
    return trait
  end

  def login_visit
    TestBrowser.browser.goto @url
    if @@ENV == "gateway"
      if browser.button(id:"details-button").present?
        browser.button(id:"details-button").click
        browser.a(id: "proceed-link").click
      end
    end
  end

  def guest_sign_up
    signupbutton = browser.a(text: 'Register your interest')
    if logout_button.present?
      log_out
      signupbutton.scroll.to
      sleep(1)
      signupbutton.click
    elsif login_button.present?
      signupbutton.scroll.to
      sleep(1)
      signupbutton.click
      guest_continue = browser.a(text: 'CONTINUE')
      guest_continue.click
    else
      raise ("unable to find either a login or logout button which is very strange and probably bad")
    end
  end

  def fill_details
    select_title(random_title)
    date_of_birth("#{Time.now.day}", "#{Time.now.month}", "#{Time.now.year - 20}")
    fill_name1('Auto LTB FN', 'Auto LTB LN')
    # fill_new_email unless browser.div(class: 'name.emailaddress').text_field.value != ""
    postcode_lookup('NW22PX')
    fill_telephone('0987612345')
    data_protection(false, false, false, false)
    continue
  end

  def new_registration
    fill_details
    fill_email2(@@new_acc_email)
    select_title(random_title)
    password = browser.text_field(id: "main_0_pagecontent_0_form_7A686591743F4EC0B53503C4317F3936_field_C1C7AC7FC92441598E7D657AF0DCD6B9border_field_C1C7AC7FC92441598E7D657AF0DCD6B9")
    confirmpassword = browser.text_field(id: "main_0_pagecontent_0_form_7A686591743F4EC0B53503C4317F3936_field_C1C7AC7FC92441598E7D657AF0DCD6B9border_confirmation")
    sendkeys!(password, "Pa55w0rd")
    sendkeys!(confirmpassword, "Pa55w0rd")
    continue
  end

end
