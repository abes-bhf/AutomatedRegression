class CorporateVolunteeringForm < GenericV2Form

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



def corp_firstname_field_v2
  firstname_field_v2 = browser.input(name: "First Name")
  return firstname_field_v2
end

def corp_lastname_field_v2
  lastname_field_v2 = browser.input(name: "Last Name")
  return lastname_field_v2
end



def corp_telephone_field_v2
  telephone_field_v2 = browser.input(name: "Telephone")
  return telephone_field_v2
end



def preferred_pcode(postcode)
  browser.input(name: "PreferredLocationPostcode").send_keys postcode
end




def journey_fin
  raise unless browser.title == "Confirmation"
  open(File.join(Dir.pwd, 'submissions/corp_volunteering.txt'), 'a') do |f|
    f << "> #{@@new_giw_email} registered on #{@@ENV} at #{Time.now} \n"
  end
end



def choice_options
  if browser.divs(class: 'f-forms__select').select.size > 2
    browser.divs(class: 'f-forms__select')[0].select.click
  end
end




def fill_form
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  corp_firstname_field_v2.send_keys (details['fn'])
  corp_lastname_field_v2.send_keys (details['ln'])
  browser.input(name: 'Organisation Name').send_keys ("Add this to yml")
  browser.input(name: 'Volunteer Count').send_keys ("15")
  dropdown_select
  email_field_v2.send_keys (@@new_giw_email)
  corp_telephone_field_v2.send_keys (details['telephone'])
  # continue
end



end
