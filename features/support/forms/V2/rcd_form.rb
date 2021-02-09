class RCDForm < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "retail-cash-donations/retail-cash-donations-form/your-donation"
    @continue = browser.button(value: 'Submit')
  end

  # def rcd_trait
  #   enquire_trait = browser.a(title: 'Get your company volunteering')
  #   return enquire_trait
  # end



  def on_page?
    begin
      rcd_trait
      @trait = rcd_trait
      #consider adding a URL check here
      Watir::Wait.until { @trait.exists? && @trait.present? }
      return true
    rescue
      return false
    end
  end




def preferred_pcode(postcode)
  browser.input(name: "PreferredLocationPostcode").send_keys postcode
end




def journey_fin
  raise unless browser.title == "Thank you"
end

def rcd_details_page(fn, ln, email)
  browser.divs(class: "f-forms__element")[1].input.send_keys fn
  browser.divs(class: "f-forms__element")[2].input.send_keys ln
  browser.divs(class: "f-forms__element")[3].input.send_keys email
end

def rcd_address_page(postcode, a1, a2, towncity)
  browser.divs(class: "f-forms__element")[0].input.send_keys postcode
  browser.divs(class: "f-forms__element")[4].input.send_keys a1
  browser.divs(class: "f-forms__element")[5].input.send_keys a2
  browser.divs(class: "f-forms__element")[7].input.send_keys towncity
end


def fill_form
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  browser.i(class: "is-amount").input.send_keys "20"
  continue
  random_radio
  continue
  dropdown_select
  rcd_details_page(details['fn'], details['ln'], details['email'])
  continue
  rcd_address_page(details['postcode'], details['a1'], details['a2'], details['towncity'])
  continue
  gdpr_field_v2
  continue
end



end
