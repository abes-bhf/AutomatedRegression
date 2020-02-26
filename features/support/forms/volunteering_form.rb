class VolunteeringForm < GenericForm

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/volunteer/register-your-interest/get-started"
    @donationamount = browser.span(id: "main_0_pagecontent_0_donations2right_0_lblPieAmount")
    @continue = browser.button(value: 'Submit')
  end

  def vol_trait
    vol_trait = browser.a(text: 'Sign up to volunteer')
    return vol_trait
  end


  def on_page?
    begin
      vol_trait
      @trait = vol_trait
      #consider adding a URL check here
      Watir::Wait.until { @trait.exists? && @trait.present? }
      return true
    rescue
      return false
    end
  end




  def fill_form
    details = EnvConfig.data['publications_data']['details']
    pub_step1(details['email'])
    browser.input(xpath: '//*[@id="f-forms__radio__guest__bb3dedd0-6a91-491b-877a-87d97dc473b2"]').click
    continue
    pub_step2
    continue
    pub_step3(details['fn'], details['ln'], random_title)
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
    email_field = browser.input(id: 'f-forms__element-input__db34cf63-37ff-4ad8-aac1-5bc64d85787c')
    sendkeys!(email_field, email)
  end

  def pub_step2
    browser.input(id: 'f-forms__radio__7cef520d-bd4a-4501-a0e6-836e5b45b8c3').click
  end



  def pub_step3(fn, ln, random_title)
    title_select = browser.div(class: 'f-forms__select').select

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
    pub_blank4(message['blank_alt_pc'], message['blank_alt_a1'], message['blank_alt_tc'])
    raise unless required_field[3].text == message['req_field']
    pub_step4(invalid['postcode'], invalid['a1'], invalid['a2'], invalid['towncity'])
    continue
    invalid_pub_4(message['short_error'], message['invalid_characters'])
    pub_step4(details['postcode'], details['a1'], details['a2'], details['towncity'])
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
    p_code = browser.div(class: 'f-forms__element').input
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
        binding.pry
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
