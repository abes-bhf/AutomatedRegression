class VolunteerEmailForm < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/volunteer/volunteer-hub/email-communications-form/sign-up"
    @continue = browser.button(value: 'Submit')
  end



  def ve_trait
    ve_trait = browser.a(title: 'Sign up to monthly volunteer e-news')
    return ve_trait
  end



  def on_page?
    begin
      ve_trait
      @trait = ve_trait
      #consider adding a URL check here
      Watir::Wait.until { @trait.exists? && @trait.present? }
      return true
    rescue
      return false
    end
  end




def journey_fin
  raise unless browser.title == "Confirmation"
  open(File.join(Dir.pwd, 'submissions/volunteering_email.txt'), 'a') do |f|
    f << "> #{@@new_giw_email} registered on #{@@ENV} at #{Time.now} \n"
  end
end




def fill_form
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  dropdown_select
  gen_details_page(details['fn'], details['ln'], @@new_giw_email)
  browser.input(name: 'Postcode').send_keys details['postcode']
  continue
end



end
