class ContactUsPage < GenericForm

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "what-we-do/contact-us"
    @continue = browser.input(value: "Submit")
  end

  def trait
    trait = browser.h1(text: 'Contact us')
    return trait
  end

  def fill_form
    details = EnvConfig.data['contact']
    begin
      retries ||= 0
      browser.a(href: "/what-we-do/contact-us/feedback-and-complaints").click
    rescue Selenium::WebDriver::Error::ElementClickInterceptedError
      retry if (retries += 1) < 4
    end
    selects = []
    browser.selects.each do |o|
      if o.present?
        selects << o
      end
    end
    selects.each do |p|
      p.options[1].click
    end
    query =  browser.textarea(id: "main_0_pagecontent_0_middlecontent_0_form_F76DDE83AF99444382BAA25611431FF2_field_2A372486618042CEA1AEE711D0B360D2")
  #  title = browser.select(id: "main_0_pagecontent_0_middlecontent_0_form_F76DDE83AF99444382BAA25611431FF2_field_A668A0C5DF42450F9C11FE98E763841C")
    lastname = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_F76DDE83AF99444382BAA25611431FF2_field_7E4D386602EE49188AF3F79594F6F824")
    firstname = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_F76DDE83AF99444382BAA25611431FF2_field_4651684B139C43F793BFAA0D7C59F962")
    email = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_F76DDE83AF99444382BAA25611431FF2_field_A92258070A0C4FC4B6656D685C0B6E7A")
    postcode = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_F76DDE83AF99444382BAA25611431FF2_field_9D0427AC3ABE4686B70D4A2E92A995E8")
    address = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_F76DDE83AF99444382BAA25611431FF2_field_100349730E914D489EB76B63D80CABB9")
    city = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_F76DDE83AF99444382BAA25611431FF2_field_C1192E73D6DA405A8EAB83992D17D18A")
    sendkeys!(query, details['query'])
    sendkeys!(firstname, details['firstname'])
    sendkeys!(lastname, details['lastname'])
    sendkeys!(email, @@disposable_email)
    sendkeys!(postcode, details['postcode'])
    sendkeys!(address, details['address'])
    sendkeys!(city, details['city'])
    c_data_protection(details['dpemail'],details['dppost'],details['dptel'])
  end

  def c_data_protection(email, post, phone)
    dp = browser.table(class: "data-protection-table")
    eml = "rbContactByEmail#{yesno(email)}"
    pst = "rbContactByPost#{yesno(post)}"
    ph = "rbContactByPhone#{yesno(phone)}"
    values = [eml, pst, ph]
    begin
    values.each do |choice|
      decision = dp.radio(value: choice)
      decision.click!
    end
    rescue
    end

  end



end
