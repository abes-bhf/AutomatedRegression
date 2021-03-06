class GiwForm < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url +"how-you-can-help/leave-a-gift-in-your-will"
    @continue = browser.button(text: "NEXT")
  end

  def trait
    trait = browser.h1(text: "Your details")
    return trait
  end

  def giw_invalid_yourdetails(email, fn, ln, random_title)
    email_field = browser.text_field(id: 'f-forms__element-input__cc1119b6-1d48-432a-848c-a78c09023363')
    sendkeys!(email_field, email)
    browser.input(id: 'f-forms__element-input__49dae068-d05d-4eeb-8190-c6ea70e16ee9').send_keys fn
    browser.input(id: 'f-forms__element-input__71ba5613-0c87-4ccb-a6d9-47deea08a9c6').send_keys ln
    continue
  end


  def yourdetails_invalid_fill
    #details = EnvConfig.data['formsV2_data']['formsV2_details']
    invalid = EnvConfig.data['formsV2_data']['formsV2_invalid']
    giw_invalid_yourdetails(invalid['email'], invalid['fn'], invalid['ln'], random_title)
    sleep 2
  end

  def yourdetails_valid_fill
    details = EnvConfig.data['formsV2_data']['formsV2_details']
    gen_details_page(details['fn'], details['ln'], @@new_giw_email)
    continue
  end

#------------------------------
  def giw_invalid_youraddress(postcode, a1, a2, towncity)
    p_code = browser.div(class: 'f-forms__element').input
    p_code.send_keys(postcode)
    browser.input(class: "f-forms__element--address1").send_keys a1
    browser.input(class: "f-forms__element--address2").send_keys a2
    sleep 1
    browser.input(class: "f-forms__element--city").send_keys towncity
  end

  # def giw_youraddress(postcode, a1, a2, towncity)
  #   p_code = browser.div(class: 'f-forms__element').input
  #   p_code.send_keys(postcode)
  #   browser.input(class: "f-forms__element--address1").send_keys a1
  #   browser.input(class: "f-forms__element--address2").send_keys a2
  #   sleep 1
  #   browser.input(class: "f-forms__element--city").send_keys towncity
  # end

  def youraddress_invalid_fill
    invalid = EnvConfig.data['formsV2_data']['formsV2_invalid']
    giw_invalid_youraddress(invalid['postcode'], invalid['a1'], invalid['a2'], invalid['towncity'])
  end

  def youraddress_valid_fill
    details = EnvConfig.data['formsV2_data']['formsV2_details']
    #giw_youraddress(details['postcode'], details['a1'], details['a2'], details['towncity'])
    gen_address_page(details['postcode'], details['a1'], details['a2'], details['towncity'])
    continue
  end

#---------------------------
  def blank_gdpr
    blank_gdpr = browser.button(class: "cta")
    return blank_gdpr
  end

  def submit_gdpr
    blank_gdpr.scroll.to :center
    sleep 1
    blank_gdpr.click
  end

  #----- HAPPY PATH ----- #

  # def valid_gdpr
  #   gdpr_field = browser.fieldset(class: "f-forms__gdpr")
  #   gdpr_field.scroll.to :top
  #   sleep 2
  #   gdpr_field.inputs.each do |i|
  #     if i.attribute_value('id').include? "no"
  #       i.click
  #     end
  #   end
  #   sleep 2
  #   #submit_gdpr
  # end


  #
  # def happy_path
  #   valid_gdpr
  #   submit_gdpr
  # end

  def output_email
    open(File.join(Dir.pwd, 'submissions/giw.txt'), 'a') do |f|
      f << "> #{@@new_giw_email} registered on #{@@ENV} at #{Time.now} \n"
    end
  end

  def press_next
    click!(browser.button(text: "Next"))
  end



end
