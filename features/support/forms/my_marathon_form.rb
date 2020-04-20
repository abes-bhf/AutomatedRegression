class MyMarathonForm < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/fundraise/my-marathon-form-2020/register/get-started"
    @continue = browser.button(value: 'Submit')
  end

  def trait
    trait = browser.h1(text: 'Your details')
    return trait
  end

  def fill_form
    details = EnvConfig.data['mymarathon']
    get_started_yes
    mm_details(details['details'])
    address(details['address'])
    gdpr_field_v2
    continue
  end

  def get_started_yes
    browser.input(:value ,"Yes").click
    continue
  end

  def mm_details(details)
    email = browser.text_field(:id, "f-forms__element-input__b1fb9280-9a0e-44d6-abb6-25c0b8e00566")
    firstname = browser.text_field(:id, "f-forms__element-input__49dae068-d05d-4eeb-8190-c6ea70e16ee9")
    lastname = browser.text_field(:id, "f-forms__element-input__71ba5613-0c87-4ccb-a6d9-47deea08a9c6")
    sendkeys!(email, @@disposable_email)
    sendkeys!(firstname, details['firstname'])
    sendkeys!(lastname, details['lastname'])
    continue
  end

  def address(address)
    postcode = browser.text_field(:id, "f-forms__element-input__572b0801-8673-43f2-b2dc-babba616043e")
    a1 = browser.text_field(:id, "f-forms__element-input__bd6cbef8-6f02-4e74-9987-29c74e132c5e")
    a2 = browser.text_field(:id, "f-forms__element-input__60714416-8346-423d-b37e-d8a7696847ac")
    towncity = browser.text_field(:id, "f-forms__element-input__aab43cae-e15b-47eb-a7a3-7532fa46d846")
    sendkeys!(postcode, address['postcode'])
    sendkeys!(a1, address['a1'])
    sendkeys!(a2, address['a2'])
    sendkeys!(towncity, address['towncity'])
    continue
  end

  # def select_worldpay
  #   sleep 2
  #   worldpay_button = browser.div(class: 'worldpay-button')
  #   worldpay_button.scroll.to :center
  #   sleep 3
  #   worldpay_button.click
  # end
  #
  #
  #
  #
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
  #
  #
  # def blank_gdpr
  #   continue
  #   gdpr_field = browser.fieldset(class: "f-forms__gdpr")
  #   gdpr_field.scroll.to :center
  #   gdpr_error = required_field[0].uls
  #   gdpr_error.each do |i|
  #     raise unless i.present?
  #   end
  #   raise unless validation_message.present?
  # end
  #
  #
  # def validation_message
  #   validation_message = browser.div(class: "f-forms__validation--notice")
  #   return validation_message
  # end
  #
  #
  # def required_field
  #   required_field = []
  #   browser.lis(class: "parsley-required").each do |i|
  #     required_field << i
  #   end
  #   return required_field
  # end
  #
  # def clear_inputs
  #   text_input = []
  #   browser.inputs.each do |o|
  #     if o.present?
  #       text_input << o
  #     end
  #     text_input.each do |i|
  #       i.to_subtype.clear
  #     end
  #   end
  # end
  #
  # def go_to_address
  #   address_url = @url + "your-address"
  #   browser.goto address_url
  #   if @@ENV == "gateway"
  #     if browser.button(id:"details-button").present?
  #       browser.button(id:"details-button").click
  #       browser.a(id: "proceed-link").click
  #     end
  #   end
  #   cookiecount = 0
  #   if cookiecount < 1
  #     cookiebutton = browser.button(id: "onetrust-accept-btn-handler")
  #     Watir::Wait.until {cookiebutton.present? && cookiebutton.exists?}
  #       begin
  #         retries ||= 0
  #         cookiebutton.click
  #       rescue Selenium::WebDriver::Error::ElementClickInterceptedError
  #         retry if (retries += 1) < 3
  #       end
  #       cookiecount = 1
  #   end
  # end
  #
  # def fill_postcode
  #   details = EnvConfig.data['publications_data']['details']
  #   p_code = browser.div(class: 'f-forms__element').text_field
  #   p_code.send_keys(details['postcode'])
  # end
  #
  # def find_address
  #   count = 0
  #   begin
  #     browser.a(text: "Find address").click
  #   rescue
  #     if count <= 4
  #       count += 1
  #       retry
  #       puts "fail count #{count}"
  #     else
  #       raise
  #     end
  #   end
  # end
  #
  # def select_address
  #   details = EnvConfig.data['publications_data']['details']
  #   sleep 1
  #   browser.div(class: 'f-forms__listbox--inner').ul.lis.each do |i|
  #     if i.text == details['lookup_match']
  #       i.click
  #
  #     end
  #   end
  # end
  #
  # def verify_address
  #   details = EnvConfig.data['publications_data']['details']
  #   sleep 1
  #   raise unless browser.input(class: "f-forms__element--address1").value == details['lookup_a1']
  #   raise unless browser.input(class: "f-forms__element--address2").value == details['lookup_a2']
  #   raise unless browser.input(class: "f-forms__element--city").value == details['lookup_city']
  # end
  #
  # def verify_summary #not complete
  #   basket_items = publications_quantity
  #   binding.pry
  #   basket_items += 1
  #   raise unless span(class: "number-items").include? basket_items
  # end


end
