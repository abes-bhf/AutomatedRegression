class JustWalkForm < GenericForm

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/fundraise/just-walk/jw-sign-up"
    @continue = browser.button(value: 'Submit')
  end

  def trait
    trait = browser.div(id: 'main_0_form_2C24BCE832054880877FD4AB82BD8B92_fieldContainer')
    return trait
  end

  def fill_form
    details = EnvConfig.data['jw']
    about_you(details['about_you'])
    contact_details(details['contact_details'])
    about_fundraising
    data_protection(false,false,false,false)
    continue
  end

  def about_you(details)
    Watir::Wait.until {browser.text.include? "About you"}
    random_title_select
    fn = browser.text_field(id: "main_0_form_2C24BCE832054880877FD4AB82BD8B92_field_C2D8F164A50C461A97D62266195BFC6C")
    ln = browser.text_field(id: "main_0_form_2C24BCE832054880877FD4AB82BD8B92_field_E36CE1CF0CB14A2DBF421BF2733919BB")
    sendkeys!(fn, details['fn'])
    sendkeys!(ln, details['ln'])
    date_of_birth("#{Time.now.day}", "#{Time.now.month}", "#{Time.now.year - 20}")
  end

  def contact_details(details)
    number = browser.text_field(id: "main_0_form_2C24BCE832054880877FD4AB82BD8B92_field_488A436A06A54126A0274158392451D0")
    email = browser.text_field(id: "main_0_form_2C24BCE832054880877FD4AB82BD8B92_field_BA676597F30E4E39A641A2DB805C15D2")
    postcode = browser.text_field(id: "main_0_form_2C24BCE832054880877FD4AB82BD8B92_field_8999700B17434DD3AE71CEF372301C2C")
    address1 = browser.text_field(id: "main_0_form_2C24BCE832054880877FD4AB82BD8B92_field_302DA7224016424D9735CD2DFF4E980C")
    town = browser.text_field(id: "main_0_form_2C24BCE832054880877FD4AB82BD8B92_field_67E4DC08A0A94C81B41C5D9E2C1B78FB")
    sendkeys!(number, details['number'])
    sendkeys!(email, @@disposable_email)
    sendkeys!(postcode, details['postcode'])
    sendkeys!(address1, details['a1'])
    sendkeys!(town, details['town'])
  end

  def about_fundraising
    motivation = browser.select(id: "main_0_form_2C24BCE832054880877FD4AB82BD8B92_field_8EA49366B12B4C7B86CF5597FB2FAF83")
    howheard = browser.select(id: "main_0_form_2C24BCE832054880877FD4AB82BD8B92_field_29804C2FFBE9411FB921F84FAAC4FC3E")
    select_date
    dropdownrandom(motivation)
    dropdownrandom(howheard)
  end

  def select_date
    sleep(1)
    walkdate = browser.text_field(id: "main_0_form_2C24BCE832054880877FD4AB82BD8B92_field_A983E1E2967B4FFBB53D144E1C5524D9")
    walkdate.click
    year_dropdown = browser.select("data-handler": "selectYear")
    dropdownselect(year_dropdown, "#{Time.now.year+1}")
    browser.table(class: "ui-datepicker-calendar").tbody.tds("data-handler": "selectDay").to_a.sample.click
  end

  def jw_end
    raise("Did not reach confirmation page for just walk") unless browser.title == "Thank for signing up to Just Walk | BHF"
    open(File.join(Dir.pwd, 'submissions/jw.txt'), 'a') do |f|
      f << "> #{@@disposable_email}} registered on #{@@ENV} at #{Time.now} \n"
    end
  end

end
