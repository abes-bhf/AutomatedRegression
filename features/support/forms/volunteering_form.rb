class VolunteeringForm < GenericForm

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/volunteer/register-your-interest/get-started"
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

  #
  # def start_vol
  #   continue
  # end
  def radio_yes_no(value)
    browser.input(value: value).click
  end

  def dropdown_field
    dropdown_field = []
    browser.divs(class: 'f-forms__select').select.each do |i|
      dropdown_field << i
    end
    return dropdown_field
  end





#insnet if check for multiple, then do each
  def dropdown_select
      dropdown_field
      dropdown_field.each do |o|
        drop_arr = []
        o.options.each do |i|
          drop_arr << i
        end
        begin
          counts ||= 0
          drop_arr.sample.click
          if o.select.value == "Select..."
            raise ArgumentException
          end
          if o.select.value ==""
            raise ArgumentException
          end
        rescue
          retry if (counts += 1) < 5
        end
      end
  end

  def enter_u17
    browser.input(id: "f-forms__element-date__day").send_keys Time.now.day
    browser.input(id: "f-forms__element-date__month").send_keys Time.now.month
    browser.input(id: "f-forms__element-date__year").send_keys (Time.now.year - 16)
    sleep 0.5
    continue
    radio_yes_no("No")
    continue
    radio_yes_no("Yes")
    continue
  end

  def enter_over18
    browser.input(id: "f-forms__element-date__day").send_keys Time.now.day
    browser.input(id: "f-forms__element-date__month").send_keys Time.now.month
    browser.input(id: "f-forms__element-date__year").send_keys (Time.now.year - 19)
    sleep 0.5
    continue
    radio_yes_no("No")
    continue
    radio_yes_no("Yes")
    continue
  end



  def complete_form_u17
    details = EnvConfig.data['publications_data']['details']
    preferred_pcode(details['postcode'])
    continue
    dropdown_select
    continue
    dropdown_select
    details_section
  end



def preferred_pcode(postcode)
  browser.input(name: "PreferredLocationPostcode").send_keys postcode
end

def vol_details(firstname, lastname, email, telephone)
  browser.input(name: "FirstName").send_keys firstname
  browser.input(name: "LastName").send_keys lastname
  browser.input(name: "Email").send_keys email
  browser.input(name: "Phone").send_keys telephone
end

def vol_address(postcode, a1, a2, towncity)
    p_code = browser.div(class: 'f-forms__element').input
    p_code.send_keys(postcode)
    browser.input(class: "f-forms__element--address1").send_keys a1
    browser.input(class: "f-forms__element--address2").send_keys a2
    browser.input(class: "f-forms__element--city").send_keys towncity
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

def journey_fin
  raise unless browser.title == "Confirmation"
end

def select_shop
  details = EnvConfig.data['publications_data']['details']
  browser.divs(class: "f-forms__checkbox")[0].label.click
  continue
  preferred_pcode(details['postcode'])
  continue
end

def select_raise
  browser.divs(class: "f-forms__checkbox")[1].label.click
  continue
end

def select_event
  details = EnvConfig.data['publications_data']['details']
  browser.divs(class: "f-forms__checkbox")[2].label.click
  continue
  preferred_pcode(details['postcode'])
  continue
end

def select_shop_and_event
  details = EnvConfig.data['publications_data']['details']
  browser.divs(class: "f-forms__checkbox")[0].label.click
  browser.divs(class: "f-forms__checkbox")[2].label.click
  continue
  preferred_pcode(details['postcode'])
  continue
end

def choice_options
  if browser.divs(class: 'f-forms__select').select.size > 2
    browser.divs(class: 'f-forms__select')[0].select.click
  end
end




def complete_form
  details = EnvConfig.data['publications_data']['details']
  dropdown_select
  continue
  dropdown_select
  details_section
end

def emergency_contact
  browser.input(name: "EmergencyFirstName").send_keys "Testfn"
  browser.input(name: "EmergencyLastName").send_keys "Testln"
  browser.input(name: "EmergencyPhone").send_keys "0123456789"
end

def details_section
  details = EnvConfig.data['publications_data']['details']
  vol_details(details['fn'], details['ln'], @@donate_email, details['telephone'])
  continue
  vol_address(details['postcode'], details['a1'], details['a2'], details['towncity'])
  continue
  if browser.title == "Emergency contact"
    emergency_contact
  end
  continue
  continue
  gdpr_field_v2
  continue
  journey_fin
end



end
