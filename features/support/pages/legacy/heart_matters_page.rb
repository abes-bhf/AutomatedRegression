class HeartMattersPage < GenericForm

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "informationsupport/heart-matters-magazine"
  end

  def trait
    trait = browser.div(class: 'log-in-form')
    return trait
  end

  def join_heart_matters
     browser.div(class: "inner").a.click
  end


  def register
    regbutton = browser.p(text: 'REGISTER')
    regbutton.click!
  end

  def login
    sleep(1)
    begin
      retries ||= 0
      email = find_textfields("Email address*")
      password = browser.text_field(id: 'main_0_pagecontent_1_form_F6CA83997EA34AE7BC868D2073E59C37_field_11071E69720C4AD28C31B5430CCC0FC3')
      sendkeys!(email, @@new_acc_email)
      sendkeys!(password, 'Pa55w0rd')
    rescue RuntimeError
      sleep(1)
      retry if (retries += 1) < 3
    rescue NoMethodError
      sleep(1)
      # retries-=1
      retry if (retries += 1) < 3
    end
    click_login
  end

  def click_login
    submitbutton = browser.input(class: 'scfSubmitButton')
    submitbutton.click!
  end

  def invalid_email_login
    begin
      retries ||= 0
      email = find_textfields("Email address*")
      password = browser.text_field(id: 'main_0_pagecontent_1_form_F6CA83997EA34AE7BC868D2073E59C37_field_11071E69720C4AD28C31B5430CCC0FC3')
      sendkeys!(email, "Hingle McCringleberry")
      sendkeys!(password, 'Pa55w0rd')
    rescue RuntimeError
      retry if (retries += 1) < 3
    rescue NoMethodError
      # retries-=1
      retry if (retries += 1) < 3
    end
    click_login
  end

  def invalid_password_login
    begin
      retries ||= 0
      email = find_textfields("Email address*")
      password = browser.text_field(id: 'main_0_pagecontent_1_form_F6CA83997EA34AE7BC868D2073E59C37_field_11071E69720C4AD28C31B5430CCC0FC3')
      sendkeys!(email, "siregara@bhf.org.uk")
      sendkeys!(password, 'Pa55w0rd')
    rescue RuntimeError
      retry if (retries += 1) < 3
    rescue NoMethodError
      retries-=1
      retry if (retries += 1) < 3
    end
    click_login
  end

  def password_validation?
    sleep(3)
    validation_summary = browser.div(class: "scfSubmitSummary").spans
    return validation_summary.size==1
  end





end
