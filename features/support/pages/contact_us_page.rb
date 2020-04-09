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
    subjectdropdown = browser.select(id: "main_0_pagecontent_0_middlecontent_0_form_5B880F10B5AC4A8DB448B8E82F0BD90F_field_8E5DAB68B20A462CB2E2131C87D8A52E")
    dropdownrandom(subjectdropdown)
    query =  browser.textarea(id: "main_0_pagecontent_0_middlecontent_0_form_5B880F10B5AC4A8DB448B8E82F0BD90F_field_F9F877837902465380CE8901B132F996")
    title = browser.select(id: "main_0_pagecontent_0_middlecontent_0_form_5B880F10B5AC4A8DB448B8E82F0BD90F_field_7ADC50D09C904D3583FFAFEA81BE664F")
    firstname = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_5B880F10B5AC4A8DB448B8E82F0BD90F_field_A0D6CA1DAB9D457185198289F30E3267")
    lastname = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_5B880F10B5AC4A8DB448B8E82F0BD90F_field_9FC1BF52E8AD4B00A131AAD997A9ABEA")
    email = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_5B880F10B5AC4A8DB448B8E82F0BD90F_field_D1892D14732E402AACD2849201F1C656")
    postcode = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_5B880F10B5AC4A8DB448B8E82F0BD90F_field_9C69BACF71C44EFE974E0E9D2C1D294E")
    address = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_5B880F10B5AC4A8DB448B8E82F0BD90F_field_997DFF7A19D846169DC70822DFF72764")
    city = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_5B880F10B5AC4A8DB448B8E82F0BD90F_field_03B32C5639D14F45AF608546FDAA3A1A")
    sendkeys!(query, details['query'])
    sendkeys!(firstname, details['firstname'])
    sendkeys!(lastname, details['lastname'])
    sendkeys!(email, @@disposable_email)
    sendkeys!(postcode, details['postcode'])
    sendkeys!(address, details['address'])
    sendkeys!(city, details['city'])
    continue
    binding.pry
  end



end
