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

  def find_inputs(label)
    inputs = []
    divs= browser.divs(class: 'scfSingleLineTextBorder')
    divs.each do |d|
      if d.text.downcase == label.downcase
      inputs << d.input
      end
    end
    if inputs.size == 1
      return inputs[0]
    else
      puts "multiple input fields with that label exist, not sure why"
      return inputs
    end
  end

  # def fill_name2(fn, ln)
  #   binding.pry
  #   first = find_inputs("First name*")
  #   last = find_inputs("Last name*")
  #   sendkeys!(first, fn)
  #   sendkeys!(last, ln)
  # end

  # def fill_name(fn, ln)
  #   first = browser.div(class: 'name.first-name').input
  #   last = browser.div(class: 'name.last-name').input
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
    first = browser.div(class: 'name.name').input
    last = browser.div(class: 'name.last-name').input
    sendkeys!(first, fn)
    sendkeys!(last, ln)
  end

  def fill_email(em)
    email = browser.div(class: 'name.e-mail').input
    sendkeys!(email, em)
  end

  def fill_email2(em)
    email = browser.div(class: 'name.emailaddress').input
    sendkeys!(email, em)
    emailabel = browser.legend(text: "Email")
    emailabel.click!
  end

  # def fill_new_email
  #   email = browser.div(class: 'name.emailaddress').input
  #   sendkeys!(email, "#{SecureRandom.hex 8}@test.org.uk")
  #   new_pw
  # end

  def fill_password
    passwordfields = browser.divs(class: 'scfConfirmPasswordBorder')
    passwordfields.each do |pw|
      sendkeys!(pw.input, 'Pa55w0rd')
    end
  end

  def postcode_lookup(pc)
    postcode = browser.div(class: 'name.postcode').div.input
    sendkeys!(postcode, pc)
    browser.a(class: 'pcaFind').click!
    postcode_dropdown = browser.select(class: 'pcaResults')
    postcode_dropdown.scroll.to
    postcode_dropdown.click!
    postcode_dropdown.options[1].click
  end

  def fill_telephone(tel)
    telephone = browser.div(class: 'scfTelephoneGeneralPanel').input
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
