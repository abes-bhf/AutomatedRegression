class CorporateVolunteeringIndividualSignupForm < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/volunteer/get-your-company-volunteering/corporate-volunteer-registration/individual-sign-up"
    @continue = browser.button(value: 'Submit')
  end

  def cvis_trait
    cvis_trait = browser.a(title: 'Get your company volunteering')
    return cvis_trait
  end


  def on_page?
    begin
      cvis_trait
      @trait = cvis_trait
      #consider adding a URL check here
      Watir::Wait.until { @trait.exists? && @trait.present? }
      return true
    rescue
      return false
    end
  end


def corp_telephone_field_v2
  telephone_field_v2 = browser.input(name: "Telephone")
  return telephone_field_v2
end


def journey_fin
  raise unless browser.title == "Thank you"
  open(File.join(Dir.pwd, 'submissions/individual_corp_volunteering.txt'), 'a') do |f|
    f << "> #{@@new_giw_email} registered on #{@@ENV} at #{Time.now} \n"
  end
end



def choice_options
  if browser.divs(class: 'f-forms__select').select.size > 2
    browser.divs(class: 'f-forms__select')[0].select.click
  end
end


def cvis_address(postcode, a1, a2, towncity)
    p_code = browser.div(class: 'f-forms__element').input
    p_code.send_keys(postcode)
    browser.input(class: "f-forms__element--address1").send_keys a1
    browser.input(class: "f-forms__element--address2").send_keys a2
    browser.input(class: "f-forms__element--city").send_keys towncity
end



def fill_form
  details = EnvConfig.data['publications_data']['details']
  continue
  dropdown_select
  firstname_field_v2.send_keys (details['fn'])
  lastname_field_v2.send_keys (details['ln'])
  # browser.input(name: 'OrganisationName').scroll.to :top
  browser.input(name: 'OrganisationName').send_keys ("Add this to yml")
  email_field_v2.send_keys (@@new_giw_email)
  corp_telephone_field_v2.send_keys (details['telephone'])
  continue
  cvis_address(details['postcode'], details['a1'], details['a2'], details['towncity'])
  continue
  gdpr_field_v2
  continue
end



end
