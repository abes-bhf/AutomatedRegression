class GenericForm < GenericPage

  def initialize(browser)
    super
  end

  def random_title
    titles = ['Ms', 'Mr', 'Mrs', 'Miss', 'Dr', 'Professor', 'Other']
    return titles.sample
  end

  def select_title(title)
    title_dropdown = browser.div(class: 'name.title').select
    dropdownselect(title_dropdown, title)
  end

  def dropdownselect(dropdown, selection)
    #takes a 'select' type html element as an argument and looks for the string provided as argument 1
    dropdown.scroll.to
    dropdown.options.each do |option|
      if option.text == selection
        option.click
      end
    end
    raise("#{selection} not found in dropdown list") unless dropdown.text == selection
  end

  def find_textfields(label)
    textfields = []
    divs= browser.divs(class: 'scfSingleLineTextBorder')
    divs.each do |d|
      if d.text.downcase == label.downcase
      textfields << d.text_field
      end
    end
    if textfields.size == 1
      return textfields[0]
    else
      puts "multiple textfield fields with that label exist, not sure why"
      return textfields
    end
  end

  # def fill_name2(fn, ln)
  #   binding.pry
  #   first = find_textfields("First name*")
  #   last = find_textfields("Last name*")
  #   sendkeys!(first, fn)
  #   sendkeys!(last, ln)
  # end

  # def fill_name(fn, ln)
  #   first = browser.div(class: 'name.first-name').textfield
  #   last = browser.div(class: 'name.last-name').textfield
  #   sendkeys!(first, fn)
  #   sendkeys!(last, ln)
  # end

  def fill_name(fn, ln)
    first = browser.div(class: "name.first-name").textarea
    last = browser.div(class: "name.last-name").textarea
    sendkeys!(first, fn)
    sendkeys!(last, ln)
  end

  def fill_name1(fn, ln)
    first = browser.div(class: 'name.name').text_field
    last = browser.div(class: 'name.last-name').text_field
    sendkeys!(first, fn)
    sendkeys!(last, ln)
  end


  def fill_email(em)
    email = browser.div(class: 'name.e-mail').text_field
    sendkeys!(email, em)
  end

  def fill_email2(em)
    email = browser.div(class: 'name.emailaddress').text_field
    sendkeys!(email, em)
    emailabel = browser.legend(text: "Email")
    emailabel.click!
  end

  # def fill_new_email
  #   email = browser.div(class: 'name.emailaddress').textfield
  #   sendkeys!(email, "#{SecureRandom.hex 8}@test.org.uk")
  #   new_pw
  # end

  def fill_password
    passwordfields = browser.divs(class: 'scfConfirmPasswordBorder')
    passwordfields.each do |pw|
      sendkeys!(pw.text_field, 'Pa55w0rd')
    end
  end

  def manual_address(address)
    address1 = browser.text_field(id: "main_0_pagecontent_0_form_8E055C52ADC344FFB848479DB2A001D7_field_A1BD006906684BDF99478FA1977CC767")
    towncity = browser.text_field(id: "main_0_pagecontent_0_form_8E055C52ADC344FFB848479DB2A001D7_field_757212F4026C426C9D95AC5C39AF2E16")
    fill_postcode(address['postcode'])
    sendkeys!(address1, address['address1'])
    sendkeys!(towncity, address['towncity'])
  end

  def postcode_lookup(pc)
    fill_postcode(pc)
    search_postcode
    select_address
  end

  def fill_postcode(pc)
    postcode = browser.div(class: 'name.postcode').div.text_field
    sendkeys!(postcode, pc)
  end

  def search_postcode
    browser.a(class: 'pcaFind').click!
  end

  def select_address
    postcode_dropdown = browser.select(class: 'pcaResults')
    postcode_dropdown.scroll.to
    postcode_dropdown.click!
    postcode_dropdown.options[1].click
  end

  def address_check(pc)
    addressfields = EnvConfig['data']['addressfields']
    expected_address = EnvConfig['data']['postcodelookup'][pc]
    expected_address.each do |x|
      begin
        retries ||= 0
        value = browser.text_field(id: addressfields[x[0]]).value
        if value == nil
          raise("Unexpected value found for #{x[0]}, expected")
        elsif value != x[1]
          raise("Expected to find #{x[1]} for #{x[0]}, instead found #{value}")
        end
      rescue RuntimeError
        retry if (retries += 1) < 3
      end
    end
  end

  def fill_telephone(tel)
    telephone = browser.div(class: 'scfTelephoneGeneralPanel').text_field
    sendkeys!(telephone, tel)
  end

  def data_protection(email, text, post, phone)
    dp = browser.table(class: "data-protection-table")
    eml = "rbContactByEmail#{yesno(email)}"
    txt = "rbContactByText#{yesno(text)}"
    pst = "rbContactByPost#{yesno(post)}"
    ph = "rbContactByPhone#{yesno(phone)}"
    values = [eml, txt, pst, ph]
    values.each do |choice|
      decision = dp.radio(value: choice)
      decision.click!
    end
  end

  def radio_selector_by_value(value)
    radiobutton = browser.radio(value: value)
    raise("Unable to locate radio button") unless radiobutton.present?
    radiobutton.scroll.to
    radiobutton.click!
  end

  def yesno(boolean)
    #turns true/false into yes/no
    if boolean
      return 'Yes'
    else
      return 'No'
    end
  end

  def validation_present?(*mandatory)
    expected_list = []
    mandatory.each do |m|
      EnvConfig.data['validation'][m].values.each do |message|
        expected_list << message.downcase
      end
    end
    v = validation_check(expected_list)
    return v
  end

  def validation_check(expected_list)
    # This method currently assumes that all DP options are available on the form, this is not always the case
    # Remember to extend this method to check which DP questions on the form first!
    validation_summary = browser.div(class: "scfValidationSummary").lis
    messages = []
    validation_summary.each do |x|
      x.wait_until(&:present?)
      x.scroll.to
      if x.present?
        messages << x.text.downcase
      end
    end
    validation_summary = browser.div(class: "scfValidationSummary").lis
    validation_summary.each do |message|
      message.text
    end
    return messages.sort == expected_list.sort
  end

  def validation_message_count(number)
    sleep(1)
    validation_summary = browser.div(class: "scfValidationSummary").lis
    return validation_summary.size == number
  end

  def date_of_birth(dd, mm, yyyy)
    optionlist = []
    day = browser.select(class: 'scfDateSelectorDay')
    month = browser.select(class: 'scfDateSelectorMonth')
    year = browser.select(class: 'scfDateSelectorYear')
    month.options.each do |option|
      optionlist << option.text
    end
    Date::MONTHNAMES.each do |month|
      optionlist << month unless month == nil
    end
    if !/\A\d+\z/.match(mm)
      raise('invalid month') unless optionlist.include?(mm)
      m = mm[0..2]
    elsif mm.class == String
      mm = mm.to_i
      raise('invalid month') unless mm < 13
      m = Date::MONTHNAMES[mm][0..2]
    end
    dropdownselect(day, dd)
    dropdownselect(month, m)
    dropdownselect(year, yyyy)
  end

  def dropdown_check(type)
    expected_options = EnvConfig.data[type]['options'].sort
    options = browser.div(id: EnvConfig.data[type]['id'][0]).select.options
    options_found = []
    options.each do |option|
      if option.text.size > 0
        options_found << option.text
      end
    end
    return options_found.sort == expected_options.sort
  end

end
