class HosForm < GenericV2Form

  def initialize(browser)
    super
    @url =EnvConfig.base_url + "how-you-can-help/fundraise/heartofsteel"
    @continue = browser.button(text: "Continue")
  end

  def select_over_sixteen
    #over_sixteen = browser.div(class: 'f-forms__checkbox ').label
    click!(checkbox)
    continue
  end

  def engraving_details
    add_engraving = browser.div(class: 'cta-label')
    click!(add_engraving)
    browser.input(class: 'engraving-name').send_keys "Automated Test"
    add_date = browser.a(text: 'Add a date')
    click!(add_date)
    browser.input(id: 'f-forms__element-date__day').send_keys "01"
    browser.input(id: 'f-forms__element-date__month').send_keys "01"
    browser.input(id: 'f-forms__element-date__year').send_keys "1990"
    add_name = browser.a(text: 'Add name')
    click!(add_name)
    continue
  end

  def hos_details(firstname, lastname, email)
    firstname_field_v2.send_keys firstname
    lastname_field_v2.send_keys lastname
    email_field_v2.send_keys email
    dropdown_select
  end

  def details_section
    details = EnvConfig.data['formsV2_data']['formsV2_details']
    hos_details(details['fn'], details['ln'], @@donate_email)
    continue
  end

  def share_my_story
    dropdown_select
    # sleep 2
    browser.scroll.to :center
    browser.textarea(id: 'f-forms__element-textarea__64923671-c659-4731-88e0-52663498c140').send_keys "TEST TEST TEST TEST"
    continue
  end

  def select_gdpr
    gdpr_field_v2
    browser.button(value: "Submit").click
  end

  def summary
    raise unless browser.text.include?("Your order summary")
    continue
  end

  def add_donation
    browser.input(value: "£50").click
    browser.scroll.to :center
    click!(browser.input(value: "Add extra donation"))
  end

  def add_gift_aid
    browser.span(class: "f-forms__radio--label").scroll.to :center
    count_1 = 0
    begin
      # browser.span(class: "f-forms__radio--label").click
      radio_yes_no("Yes")
    rescue
      retry if (count_1 += 1) < 4
    end
    click!(checkbox)
  end

  def hos_confirmation
      hos_count = 0
      begin
        raise("test") unless browser.text.include? ("Thank you for your support!")
      rescue
        retry if (hos_count += 1) < 4
      end
      open(File.join(Dir.pwd, 'submissions/hos.txt'), 'a') do |f|
        f << "> #{@@donate_email} registered on #{@@ENV} at #{Time.now} \n"
      end
  end

end
