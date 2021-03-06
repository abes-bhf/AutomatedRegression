class VolunteeringForm < GenericV2Form

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

  # browser.input(id: "f-forms__element-date__day").send_keys Time.now.day
  # browser.input(id: "f-forms__element-date__month").send_keys Time.now.month
  # browser.input(id: "f-forms__element-date__year").send_keys (Time.now.year - 16)

  def enter_u17
    date_field_day_v2.send_keys Time.now.day
    date_field_month_v2.send_keys Time.now.month
    date_field_year_v2.send_keys (Time.now.year - 16)
    sleep 0.5
    continue
    Watir::Wait.until {browser.text.include? ("criminal")}
    radio_yes_no("No")
    continue
    Watir::Wait.until {browser.text.include? ("UK address")}
    radio_yes_no("Yes")
    continue
  end

  def enter_over18
    date_field_day_v2.send_keys Time.now.day
    date_field_month_v2.send_keys Time.now.month
    date_field_year_v2.send_keys (Time.now.year - 19)
    sleep 0.5
    continue
    Watir::Wait.until {browser.text.include? ("criminal")}
    radio_yes_no("No")
    continue
    Watir::Wait.until {browser.text.include? ("UK address")}
    radio_yes_no("Yes")
    continue
  end



  def complete_form_u17
    details = EnvConfig.data['formsV2_data']['formsV2_details']
    preferred_pcode(details['postcode'])
    continue
    dropdown_select
    continue
    dropdown_select
    continue
    details_section
  end



def preferred_pcode(postcode)
  browser.input(name: "PreferredLocationPostcode").send_keys postcode
end

def vol_details(firstname, lastname, email, telephone)
  firstname_field_v2.send_keys firstname
  lastname_field_v2.send_keys lastname
  email_field_v2.send_keys email
  browser.input(name: "Phone").send_keys telephone
end


def journey_fin
  continue
  raise unless browser.title == "Confirmation"
  open(File.join(Dir.pwd, 'submissions/volunteering.txt'), 'a') do |f|
    f << "> #{@@donate_email} registered on #{@@ENV} at #{Time.now} \n"
  end
end

def select_shop
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  begin
    retries ||= 0
    browser.divs(class: "f-forms__checkbox")[0].label.click
  rescue Selenium::WebDriver::Error::ElementClickInterceptedError
    retry if (retries += 1) < 5
  end
  continue
  preferred_pcode(details['postcode'])
  continue
end

def select_raise
  begin
    retries ||= 0
    browser.divs(class: "f-forms__checkbox")[1].label.click
  rescue Selenium::WebDriver::Error::ElementClickInterceptedError
    retry if (retries += 1) < 5
  end
  continue
end

def select_event
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  browser.divs(class: "f-forms__checkbox")[2].label.click
  continue
  preferred_pcode("NW17AW")
    # preferred_pcode(details['postcode'])
  continue
end

def select_shop_and_event
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  browser.divs(class: "f-forms__checkbox")[0].label.click
  browser.divs(class: "f-forms__checkbox")[2].label.click
  continue
  preferred_pcode("NW17AW")
  continue
end

def choice_options
  if browser.divs(class: 'f-forms__select').select.size > 2
    browser.divs(class: 'f-forms__select')[0].select.click
  end
end




def complete_form
  details = EnvConfig.data['formsV2_data']['formsV2_details']
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
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  vol_details(details['fn'], details['ln'], @@donate_email, details['telephone'])
  continue
  gen_address_page(details['postcode'], details['a1'], details['a2'], details['towncity'])
  continue
  if browser.title == "Emergency contact"
    emergency_contact
  end
  continue
  continue
  gdpr_field_v2
end

#Selenium::WebDriver::Error::ElementClickInterceptedError
def select_shop_and_awareness
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  begin
    retries ||= 0
    browser.divs(class: "f-forms__checkbox")[0].label.click
    browser.divs(class: "f-forms__checkbox")[1].label.click
  rescue
    retry if (retries += 1) < 3
  end
  browser.divs(class: "f-forms__checkbox")[1].label.click
  continue
  preferred_pcode(details['postcode'])
  continue
end

def go_to_address
  address_url = EnvConfig.base_url + "how-you-can-help/volunteer/register-your-interest/your-address"
  browser.goto address_url
  if @@ENV == "gateway"
    if browser.button(id:"details-button").present?
      browser.button(id:"details-button").click
      browser.a(id: "proceed-link").click
    end
  end
  cookiecount = 0
  if cookiecount < 1
    cookiebutton = browser.button(id: "onetrust-accept-btn-handler")
    Watir::Wait.until {cookiebutton.present? && cookiebutton.exists?}
      begin
        retries ||= 0
        cookiebutton.click
      rescue Selenium::WebDriver::Error::ElementClickInterceptedError
        retry if (retries += 1) < 3
      end
      cookiecount = 1
  end
end

def fill_postcode
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  postcode_field_v2.send_keys(details['postcode'])
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

# 49 may need changing if postcode numbers change/ myb size max|  & dropbox.ul.lis[49].present?
def select_address
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  dropbox = browser.div(class: 'f-forms__listbox--inner')
  Watir::Wait.until {dropbox.present?}
  dropbox.ul.lis.each do |i|
    if i.text == details['lookup_match']
      i.click
      break
    end
  end
end

def verify_address
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  sleep 1
  raise unless browser.input(class: "f-forms__element--address1").value == details['lookup_a1']
  raise unless browser.input(class: "f-forms__element--address2").value == details['lookup_a2']
  raise unless browser.input(class: "f-forms__element--city").value == details['lookup_city']
end





end
