class LoginRegisterPage < GenericForm

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "login"
  end

  def trait
    trait = browser.div(class: 'log-in-form')
    return trait
  end

  def register
    regbutton = browser.p(text: 'REGISTER')
    regbutton.click!
  end

  def login
    email = find_inputs('Email address*')
    password = browser.input(id: 'main_0_pagecontent_1_form_F6CA83997EA34AE7BC868D2073E59C37_field_11071E69720C4AD28C31B5430CCC0FC3')
    sendkeys!(email, @@new_acc_email)
    sendkeys!(password, 'Pa55w0rd')
    submitbutton = browser.input(class: 'scfSubmitButton')
    binding.pry
  end

end
