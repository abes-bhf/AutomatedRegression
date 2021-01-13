class HouseClearanceV2Form < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "kris-hc-sample/hc/time-frame"
    @continue = browser.button(value: 'Submit')
  end



def date_entry
  date_field_day_v2.send_keys Time.now.day
  date_field_month_v2.send_keys Time.now.month
  date_field_year_v2.send_keys (Time.now.year + 1)
end

def hc_details_page(fn, ln, email)
  firstname_field_v2.send_keys fn
  lastname_field_v2.send_keys ln
  browser.input(type: "tel").send_keys "0123456789"
  browser.input(type: "email").send_keys email
end

def submit_form
  details = EnvConfig.data['formsV2_data']['formsV2_details']
  # (details['postcode'])
  random_radio
  continue
  dropdown_select
  fnev2_details(details['fn'], details['ln'], "DigitalTestTeam@bhf.org.uk", details['telephone'])
  #details['email']
  continue
  fnev2_address(details['a1'], details['a2'], details['towncity'])
  radio_yes_no("Yes")
  continue
  radio_yes_no("No")
  continue
  dropdown_select
  continue
  gdpr_field_v2
  continue
  stupid_hc_checkbox
  continue
  output_reference
end

def stupid_hc_checkbox
  count = 0
  until count == 8
    browser.send_keys :tab
    count += 1
  end
  browser.send_keys :space
end

#the below is not working
def output_reference
  ref = browser.span(class: "is-editable-field").ps[1].text
  Watir::Wait.until {browser.span(class: "is-editable-field").present?}
    begin
      puts ref
    end
end



def fnev2_details(firstname, lastname, email, telephone)
  firstname_field_v2.send_keys firstname
  lastname_field_v2.send_keys lastname
  browser.input(name: "EmailAddress").send_keys email
  browser.input(name: "PhoneNumber").send_keys telephone
end

def fnev2_address(a1, a2, towncity)
    browser.a(class: 'show-container-trigger').click!
    address1_field_v2.send_keys a1
    address2_field_v2.send_keys a2
    city_field_v2.send_keys towncity
end


#figure out regex
def journey_fin
  browser.span(class: 'is-editable-field').ps[2].wait_until(&:present?)
  begin
    sleep 0.5
  # raise unless browser.span(class: 'is-editable-field').ps[2].text.include? "Your booking reference number:"
  raise unless browser.title == "Thank you"
  end
  open(File.join(Dir.pwd, 'submissions/fnev2.txt'), 'a') do |f|
    f << "> #{@@donate_email} registered on #{@@ENV} at #{Time.now} \n"
  end
end







end
