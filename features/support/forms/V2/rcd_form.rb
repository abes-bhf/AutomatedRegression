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




def fill_form
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  browser.input(name: "DonationAmount").send_keys "20"
  continue
  random_radio
  continue
  if browser.title == "Own Money"
    radio_yes_no("yes")
    continue
  end
  dropdown_select
  gen_details_page(details['fn'], details['ln'], details['email'])
  continue
  gen_address_page(details['postcode'], details['a1'], details['a2'], details['towncity'])
  continue
  gdpr_field_v2
  continue
  continue
end



end
