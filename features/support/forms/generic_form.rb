class GenericForm < GenericPage

  def initialize(browser)
    super
  end

  def sendkeys!(input, text)
    # takes an input html element as the 1st argument, scrolls to it then fills it with the keys provided in the second argument)
    input.scroll.to
    input.send_keys(text)
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
    raise unless dropdown.text == selection
  end

  def fill_name(fn, ln)
    first = browser.input(id: 'main_0_pagecontent_0_form_8E055C52ADC344FFB848479DB2A001D7_field_69FAFF59EC3F48D9B0DB856338B988D6')
    last = browser.input(id: 'main_0_pagecontent_0_form_8E055C52ADC344FFB848479DB2A001D7_field_096F6DDA72A34E118CED7CA79FE6276B')
    sendkeys!(first, fn)
    sendkeys!(last, ln)
  end

  def fill_email(em)
    email = browser.input(id: 'main_0_pagecontent_0_form_8E055C52ADC344FFB848479DB2A001D7_field_BBBAE32901A64DD68F4053FE55319A7F')
    sendkeys!(email, em)
  end

  def postcode_lookup(pc)
    postcode = browser.input(id: 'main_0_pagecontent_0_form_8E055C52ADC344FFB848479DB2A001D7_field_CE18DEEFF98A4292956D7A2904E98B39')
    sendkeys!(postcode, pc)
    browser.a(class: 'pcaFind').click
    postcode_dropdown_options = browser.select(class: 'pcaResults').options
    postcode_dropdown_options[1].click
  end

  def fill_telephone(tel)
    telephone = browser.input(id: 'main_0_pagecontent_0_form_8E055C52ADC344FFB848479DB2A001D7_field_0F7A608B75A743558549862A28466887')
    sendkeys!(telephone, tel)
  end

  def data_protection(email, text, post, phone)
    dp = browser.table(class: "data-protection-table")
    dp.scroll.to
    eml = "rbContactByEmail#{yesno(email)}"
    txt = "rbContactByText#{yesno(text)}"
    pst = "rbContactByPost#{yesno(post)}"
    ph = "rbContactByPhone#{yesno(phone)}"
    values = [eml, txt, pst, ph]
    values.each do |choice|
      dp.radio(value: choice).set
    end
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
  end

  def validation_check(expected_list)
    # This method currently assumes that all DP options are available on the form, this is not always the case
    # Remember to extend this method to check which DP questions on the form first!
    validation_summary = browser.div(class: "scfValidationSummary").lis
    messages = []
    validation_summary.each do |x|
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

end
