class FAndEFormsV2 < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "shop/donating-goods/book-furniture-collection-near-me/"
    @continue = browser.button(value: 'Submit')
    # @trait = browser.h1(text: "Book a free collection")
  end

  def trait
    trait = browser.h1(text: "Book a free collection")
    return trait
  end


def date_entry
  date_field_day_v2.send_keys Time.now.day
  date_field_month_v2.send_keys Time.now.month
  date_field_year_v2.send_keys (Time.now.year + 1)
end


def fill_form
  details = EnvConfig.data['publications_data']['details']
  # (details['postcode'])
  postcode_field_v2.send_keys "XX1 1XX"
  continue
  continue
  random_radio
  continue
  date_entry
  browser.divs(class: 'f-forms__checkbox ')[0].label.scroll.to :center
  sleep 0.5
  browser.divs(class: 'f-forms__checkbox ')[0].label.click
  continue
  sleep 0.5
  dropdown_select
  fnev2_details(details['fn'], details['ln'], @@donate_email, details['telephone'])
  #
  # DigitalTestTeam@bhf.org.uk
  continue
  fnev2_address(details['a1'], details['a2'], details['towncity'])
  random_radio
  if browser.input(name: 'CollectionLocation2').present?
    browser.input(name: 'CollectionLocation2').send_keys "Under the doormat"
  end
  continue
  click!(checkbox)
  continue
  click!(checkbox)
  continue
  radio_yes_no("No")
  continue
  gdpr_field_v2
  continue
end


def fnev2_details(firstname, lastname, email, telephone)
  firstname_field_v2.send_keys firstname
  lastname_field_v2.send_keys lastname
  browser.input(name: "EmailAddress").send_keys "DigitalTestTeam@bhf.org.uk"
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
