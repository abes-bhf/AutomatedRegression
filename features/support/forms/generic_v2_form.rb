class GenericV2Form < GenericForm

  def initialize(browser)
    super
  end

#
# def date_entry(day, month, year)
#   date_field_day_v2.send_keys (Time.now.day + day)
#   date_field_month_v2.send_keys (Time.now.month + month)
#   date_field_year_v2.send_keys (Time.now.year + year)
# end


  def find_trait
    @trait = browser.div(class: 'order-ref-number')
  end

  def on_page?
    begin
      find_trait
      @trait = trait
      #consider adding a URL check here
      Watir::Wait.until { @trait.exists? && @trait.present? }
      return true
    rescue
      return false
    end
  end

  def validation_message_count(number)
    sleep(1)
    validation_summary = browser.uls(class: "filled")
    return validation_summary.size == number
  end

#  def invalid_email(email)
#    browser.input(name: 'Email')#.to_subtype.clear_inputs
#  end

# for radio buttons, eg yes and no
  def radio_yes_no(value)
    browser.input(value: value).click
  end

#select a random radio from a long list
  def random_radio
    radios = []
    browser.inputs(type: 'radio').each do |o|
      radios << o
    end
    radios.sample.click
  end


  def checkbox
    checkbox = browser.div(class: 'f-forms__checkbox').label
    return checkbox
  end


  def dropdown_field
    dropdown_field = []
    browser.divs(class: 'f-forms__select').select.each do |i|
      dropdown_field << i
    end
    return dropdown_field
  end

  # Selects a random item from each dropdown list on the page
  def dropdown_select
      Watir::Wait.until {browser.div(class: 'f-forms__select').select.present?}
      dropdown_field
      dropdown_field.each do |o|
        drop_arr = []
        o.options.each do |i|
          drop_arr << i
        end
        begin
          counts ||= 0
          drop_arr.sample.click
          if o.select.value == "Select..."
            raise ArgumentException
          end
          if o.select.value == ""
            raise ArgumentException
          end
        rescue
          retry if (counts += 1) < 5
        end
      end
  end

  def firstname_field_v2
    firstname_field_v2 = browser.input(name: "FirstName")
    return firstname_field_v2
  end

  def lastname_field_v2
    lastname_field_v2 = browser.input(name: "LastName")
    return lastname_field_v2
  end

  def email_field_v2
    email_field_v2 = browser.input(name: "Email")
    return email_field_v2
  end

  def address1_field_v2
    address1_field_v2 = browser.input(class: "f-forms__element--address1")
    return address1_field_v2
  end

  def address2_field_v2
    address2_field_v2 = browser.input(class: "f-forms__element--address2")
    return address2_field_v2
  end

  def city_field_v2
    city_field_v2 = browser.input(class: "f-forms__element--city")
    return city_field_v2
  end

  def postcode_field_v2
    postcode_field_v2 = browser.input(name: /^*Postcode$/)
    return postcode_field_v2
  end

  def date_field_day_v2
    date_field_day_v2 = browser.input(id: "f-forms__element-date__day")
    return date_field_day_v2
  end

  def date_field_month_v2
    date_field_month_v2 = browser.input(id: "f-forms__element-date__month")
    return date_field_month_v2
  end

  def date_field_year_v2
    date_field_year_v2 = browser.input(id: "f-forms__element-date__year")
    return date_field_year_v2
  end

  def gen_details_page(fn, ln, email)
    firstname_field_v2.send_keys fn
    lastname_field_v2.send_keys ln
    email_field_v2.send_keys email
  end



  def gen_address_page(postcode, a1, a2, towncity)
      postcode_field_v2.send_keys postcode
      address1_field_v2.send_keys a1
      address2_field_v2.send_keys a2
      city_field_v2.send_keys towncity
  end

  def gdpr_field_v2
    gdpr_field = browser.fieldset(class: "f-forms__gdpr")
    gdpr_field.scroll.to :top
    sleep 1
    gdpr_field.inputs.each do |i|
      if i.attribute_value('id').include? "no"
        i.click
      end
    end
  end

end
