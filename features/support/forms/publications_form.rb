class PublicationsForm < GenericForm

  def initialize(browser)
    super
    @url = EnvConfig.publications_url
    @donationamount = browser.span(id: "main_0_pagecontent_0_donations2right_0_lblPieAmount")
    @continue = browser.button(value: 'Submit')
  end

  def trait
    trait = browser.h1(text: 'Your details')
    return trait
  end

  def fill_form
    details = EnvConfig.data['publications_data']['details']
    pub_step1(details['email'])
    browser.input(value: 'Continue as a guest').click
    continue
    pub_step2
    continue
    pub_step3(details['email'], details['fn'], details['ln'], random_title)
    continue
    pub_step4(details['postcode'], details['a1'], details['a2'], details['towncity'])
    continue
    gdpr_field_v2
  end

  def select_worldpay
    sleep 2
    worldpay_button = browser.div(class: 'worldpay-button')
    worldpay_button.scroll.to :center
    sleep 3
    worldpay_button.click
  end



  def pub_step1(email)
    email_field = browser.text_field(id: 'f-forms__element-input__db34cf63-37ff-4ad8-aac1-5bc64d85787c')
    sendkeys!(email_field, email)
  end

  def pub_step2
    browser.input(id: 'f-forms__radio__7cef520d-bd4a-4501-a0e6-836e5b45b8c3').click
  end



  def pub_step3(email, fn, ln, random_title)
    title_select = browser.div(class: 'f-forms__select').select
    raise unless browser.input(name: 'Email').value == email
    drop_title = random_title
    title_select.options.each do |option|
      if option.text == random_title
        option.click
      end
    end
    browser.input(id: 'f-forms__element-input__3f094594-ab93-45ba-ba3e-20182e4958d2').send_keys fn
    browser.input(id: 'f-forms__element-input__269005c6-9f17-47dd-b67e-455b746f80db').send_keys ln
  end

  def pub_step4(postcode, a1, a2, towncity)
    p_code = browser.div(class: 'f-forms__element').input
    p_code.send_keys(postcode)
    browser.input(class: "f-forms__element--address1").send_keys a1
    browser.input(class: "f-forms__element--address2").send_keys a2
    sleep 1
    browser.input(class: "f-forms__element--city").send_keys towncity
    same_billing = browser.div(class: 'f-forms__radio')
      if same_billing.present?
        same_billing.scroll.to :center
        sleep 1
        browser.input(class: "f-forms__element--city").send_keys(:tab, :tab, :space)
      end
  end



  def gdpr_field_v2
    gdpr_field = browser.fieldset(class: "f-forms__gdpr")
    gdpr_field.scroll.to :top
    sleep 1
    gdpr_field.inputs.each do |i|
      if i.attribute_value('id').include? "no"
        i.click
      end
    end
  end

  def sign_in
    details = EnvConfig.data['publications_data']['details']
    pub_step1(details['registered_email'])
    browser.input(id: 'f-forms__radio__signin__bb3dedd0-6a91-491b-877a-87d97dc473b2').click
    browser.input(id: 'f-forms__element-input-nested__bb3dedd0-6a91-491b-877a-87d97dc473b2').send_keys(details['password'])
    continue
  end

  def fill_the_rest
    details = EnvConfig.data['publications_data']['details']
    pub_step2
    continue
    continue
    check_signedin
    browser.input(id: 'f-forms__radio__7b620449-e4e5-4607-83cc-d5540418cbd6').scroll.to :center
    sleep 1
    browser.input(id: 'f-forms__radio__7b620449-e4e5-4607-83cc-d5540418cbd6').click
    continue
      if browser.title == "Delivery address"
        pub_step4(details['postcode'], details['a1'], details['a2'], details['towncity'])
        continue
      end
    gdpr_field_v2
  end

  def check_signedin
    sleep 1
    raise unless browser.input(class: "f-forms__element--address1").value.length > 1
    raise unless browser.input(class: "f-forms__element--address2").value.length > 1
    raise unless browser.input(class: "f-forms__element--city").value.length > 1
  end



  def firing_blanks
    details = EnvConfig.data['publications_data']['details']
    blanks = EnvConfig.data['publications_data']['pub_validation_messages']
    pub_blank1(blanks['req_field'])
    pub_step1(details['email'])
    browser.input(xpath: '//*[@id="f-forms__radio__guest__bb3dedd0-6a91-491b-877a-87d97dc473b2"]').click
    continue
    pub_blank2(blanks['req_field'])
    sleep 1
    pub_step2
    continue
    pub_blank3(blanks['blank_fn'], blanks['blank_ln'], blanks['blank_title'])
    pub_step3(details['fn'], details['ln'], random_title)
    continue
    pub_blank4(blanks['blank_pc'], blanks['blank_a1'], blanks['blank_towncity'])
    pub_step4(details['postcode'], details['a1'], details['a2'], details['towncity'])
    continue
    blank_gdpr
    sleep 1
    gdpr_field_v2
    continue
  end

  def pub_blank1(req_field)
    continue
    raise unless required_field[1].text == req_field
    raise unless required_field[0].text == req_field
    raise unless validation_message.present?
  end

  def pub_blank2(req_field)
    continue
    raise unless required_field[0].text == req_field
    raise unless validation_message.present?
  end

  def pub_blank3(blank_fn, blank_ln, blank_title)
    continue
    raise unless required_field[0].text == blank_fn
    raise unless required_field[1].text == blank_ln
    raise unless browser.li(class: 'parsley-custom-error-message').text == blank_title
    raise unless validation_message.present?
  end

  def pub_blank4(blank_pc, blank_a1, blank_towncity)
    continue
    raise unless required_field[0].text == blank_pc
    raise unless required_field[1].text == blank_a1
    raise unless required_field[2].text == blank_towncity
    raise unless validation_message.present?
  end

  def blank_gdpr
    continue
    gdpr_field = browser.fieldset(class: "f-forms__gdpr")
    gdpr_field.scroll.to :center
    gdpr_error = required_field[0].uls
    gdpr_error.each do |i|
      raise unless i.present?
    end
    raise unless validation_message.present?
  end


  def validation_message
    validation_message = browser.div(class: "f-forms__validation--notice")
    return validation_message
  end

  def parsley_pattern
    parsley_pattern = []
    browser.lis(class: "parsley-pattern").each do |i|
      parsley_pattern << i
    end
    return parsley_pattern
  end

  def required_field
    required_field = []
    browser.lis(class: "parsley-required").each do |i|
      required_field << i
    end
    return required_field
  end

  def invalid_fill
    details = EnvConfig.data['publications_data']['details']
    invalid = EnvConfig.data['publications_data']['pub_invalid']
    message = EnvConfig.data['publications_data']['pub_validation_messages']
    pub_step1(invalid['email'])
    browser.input(xpath: '//*[@id="f-forms__radio__guest__bb3dedd0-6a91-491b-877a-87d97dc473b2"]').click
    continue
    invalid_pub_1(message['invalid_email'])
    pub_step1(details['email'])
    browser.input(xpath: '//*[@id="f-forms__radio__guest__bb3dedd0-6a91-491b-877a-87d97dc473b2"]').click
    continue
    pub_step2
    continue
    pub_step3(invalid['fn'], invalid['ln'], random_title)
    continue
    invalid_pub_3(message['invalid_fn'],message['invalid_ln'])
    pub_step3(details['fn'], details['ln'], random_title)
    continue
    pub_step4(invalid['postcode'], invalid['a1'], invalid['a2'], invalid['towncity'])
    continue
    invalid_pub_4(message['short_error'], message['invalid_characters'])
    pub_step4(details['postcode'], details['a1'], details['a2'], details['towncity'])
    continue
    gdpr_field_v2
  end

  def invalid_pub_1(email)
    raise unless browser.text.include?(email)
    raise unless validation_message.present?
    browser.input(id: 'f-forms__element-input__db34cf63-37ff-4ad8-aac1-5bc64d85787c').to_subtype.clear
  end

  def invalid_pub_3(fn, ln)
    raise unless parsley_pattern[0].text == fn
    raise unless parsley_pattern[1].text == ln
    raise unless validation_message.present?
    clear_inputs
  end

  def invalid_pub_4(short_error, invalid_characters)
    raise unless parsley_pattern[0].text == invalid_characters
    raise unless parsley_pattern[1].text == invalid_characters
    raise unless parsley_pattern[2].text == invalid_characters
    raise unless browser.li(class: "parsley-length").text == short_error
    raise unless validation_message.present?
    clear_inputs
  end

  def clear_inputs
    text_input = []
    browser.inputs.each do |o|
      if o.present?
        text_input << o
      end
      text_input.each do |i|
        i.to_subtype.clear
      end
    end
  end


  def fill_company_form
    details = EnvConfig.data['publications_data']['details']
    pub_step1(details['email'])
    browser.input(xpath: '//*[@id="f-forms__radio__guest__bb3dedd0-6a91-491b-877a-87d97dc473b2"]').click
    continue
    company_step2
    continue
    org_type
    continue
    pub_step3(details['fn'], details['ln'], random_title)
    continue
    pub_step4(details['postcode'], details['a1'], details['a2'], details['towncity'])
    continue
    gdpr_field_v2
  end

  def company_step2
    browser.input(value: "I'm ordering for an organisation").click
  end

  def org_type
    orgs = []
    browser.inputs(name: 'What type of organisation do you work for').each do |i|
      orgs << i
    end
    choice = orgs.sample
    choice.scroll.to :center
    sleep 1
    choice.click
  end

  def fill_friend_form
    details = EnvConfig.data['publications_data']['details']
    pub_step1(details['email'])
    browser.input(xpath: '//*[@id="f-forms__radio__guest__bb3dedd0-6a91-491b-877a-87d97dc473b2"]').click
    continue
    friend_step2
    continue
    pub_step3(details['fn'], details['ln'], random_title)
    continue
    pub_step4(details['postcode'], details['a1'], details['a2'], details['towncity'])
    continue
    gdpr_field_v2
  end

  def friend_step2
    browser.input(value: "This is for a friend/relative/someone I know").click
  end

  def different_billing
    details = EnvConfig.data['publications_data']['details']
    pub_step1(details['email'])
    browser.input(xpath: '//*[@id="f-forms__radio__guest__bb3dedd0-6a91-491b-877a-87d97dc473b2"]').click
    continue
    pub_step2
    continue
    pub_step3(details['fn'], details['ln'], random_title)
    continue
    address_step_4(details['postcode'], details['a1'], details['a2'], details['towncity'])
    continue
    pub_step4(details['alt_pc'], details['alt_a1'],details['alt_a2'], details['alt_tc'])
    continue
    gdpr_field_v2
  end

  def address_step_4(postcode, a1, a2, towncity)
    p_code = browser.div(class: 'f-forms__element').text_field
    p_code.send_keys(postcode)
    browser.text_field(class: "f-forms__element--address1").send_keys a1
    browser.text_field(class: "f-forms__element--address2").send_keys a2
    sleep 1
    browser.text_field(class: "f-forms__element--city").send_keys towncity
    same_billing = browser.div(class: 'f-forms__radio')
      if same_billing.present?
        same_billing.scroll.to :center
        sleep 1
        browser.input(value: "No").click
      end
  end

  def signedin_validation
    details = EnvConfig.data['publications_data']['details']
    invalid = EnvConfig.data['publications_data']['pub_invalid']
    message = EnvConfig.data['publications_data']['pub_validation_messages']
    browser.input(id: 'f-forms__radio__signin__bb3dedd0-6a91-491b-877a-87d97dc473b2').click
    signedin_blank_1(message['req_field'], message['req_field_alt'])
    pub_step1(invalid['email'])
    invalid_pub_1(message['invalid_email'])
    sign_in
    pub_step2
    continue
    continue
    continue
    browser.labels(class: "f-forms__radio--element")[1].scroll.to :center
    sleep 2
    browser.labels(class: "f-forms__radio--element")[1].click
    continue
    pub_step4(details['alt_pc'], details['alt_a1'],details['alt_a2'], details['alt_tc'])
    continue
    gdpr_field_v2
  end

  def signedin_blank_1(req_field, req_field_alt)
    continue
    raise unless required_field[0].text == req_field
    raise unless required_field[1].text == req_field_alt
    raise unless validation_message.present?
  end

  def go_to_address
    address_url = @url + "/your-address"
    browser.goto address_url
  end

  def fill_postcode
    details = EnvConfig.data['publications_data']['details']
    p_code = browser.div(class: 'f-forms__element').text_field
    p_code.send_keys(details['postcode'])
  end

  def find_address
    count = 0
    begin
      browser.a(text: "Find address").click
    rescue
      if count <= 4
        count += 1
        retry
        puts "fail count #{count}"
      else
        raise
      end
    end
  end

  def select_address
    details = EnvConfig.data['publications_data']['details']
    sleep 1
    browser.div(class: 'f-forms__listbox--inner').ul.lis.each do |i|
      if i.text == details['lookup_match']
        i.click

      end
    end
  end

  def verify_address
    details = EnvConfig.data['publications_data']['details']
    sleep 1
    raise unless browser.input(class: "f-forms__element--address1").value == details['lookup_a1']
    raise unless browser.input(class: "f-forms__element--address2").value == details['lookup_a2']
    raise unless browser.input(class: "f-forms__element--city").value == details['lookup_city']
  end

  def verify_summary #not complete
    basket_items = publications_quantity
    binding.pry
    basket_items += 1
    raise unless span(class: "number-items").include? basket_items
  end


























end
