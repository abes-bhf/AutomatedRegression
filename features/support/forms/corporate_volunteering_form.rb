class CorporateVolunteeringForm < GenericForm

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/volunteer/get-your-company-volunteering/get-your-company-volunteering-form/sign-up"
    @continue = browser.button(value: 'Submit')
  end

  def enquire_trait
    enquire_trait = browser.a(title: 'Get your company volunteering')
    return enquire_trait
  end


  def on_page?
    begin
      enquire_trait
      @trait = enquire_trait
      #consider adding a URL check here
      Watir::Wait.until { @trait.exists? && @trait.present? }
      return true
    rescue
      return false
    end
  end


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


def corp_firstname_field_v2
  firstname_field_v2 = browser.input(name: "First Name")
  return firstname_field_v2
end

def corp_lastname_field_v2
  lastname_field_v2 = browser.input(name: "Last Name")
  return lastname_field_v2
end

def email_field_v2
  email_field_v2 = browser.input(name: "Email")
  return email_field_v2
end

def corp_telephone_field_v2
  telephone_field_v2 = browser.input(name: "Telephone")
  return telephone_field_v2
end

def address1_field_v2
  address1_field_v2 = browser.input(class: "f-forms__element--address1")
  return address1_field_v2
end

def address2_field_v2
  address2_field_v2 = browser.input(class: "f-forms__element--address2")
  return address2_field_v2
end

def city_field_v2
  city_field_v2 = browser.input(class: "f-forms__element--city")
  return city_field_v2
end

def postcode_field_v2
  postcode_field_v2 = browser.div(class: 'f-forms__element').input
  return postcode_field_v2
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



def choice_options
  if browser.divs(class: 'f-forms__select').select.size > 2
    browser.divs(class: 'f-forms__select')[0].select.click
  end
end




def fill_form
  details = EnvConfig.data['publications_data']['details']
  corp_firstname_field_v2.send_keys (details['fn'])
  corp_lastname_field_v2.send_keys (details['ln'])
  browser.input(name: 'Organisation Name').send_keys ("Add this to yml")
  browser.input(name: 'Volunteer Count').send_keys ("15")
  dropdown_select
  email_field_v2.send_keys (@@new_giw_email)
  corp_telephone_field_v2.send_keys (details['telephone'])
  continue
end



end
