class FAndEFormsV2 < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "/shop/donating-goods/book-furniture-collection-near-me/"
    @continue = browser.button(value: 'Submit')
  end

  # def fnev2_trait
  #   vol_trait = browser.a(text: 'TO be confirmed')
  #   return vol_trait
  # end


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


  # def radio_yes_no(value)
  #   browser.input(value: value).click
  # end
  #
  # def dropdown_field
  #   dropdown_field = []
  #   browser.divs(class: 'f-forms__select').select.each do |i|
  #     dropdown_field << i
  #   end
  #   return dropdown_field
  # end





# #insnet if check for multiple, then do each
#   def dropdown_select
#       dropdown_field
#       dropdown_field.each do |o|
#         drop_arr = []
#         o.options.each do |i|
#           drop_arr << i
#         end
#         begin
#           drop_arr.sample.click
#           if o.select.value == "Select..."
#             raise ArgumentException
#           end
#           if o.select.value ==""
#             raise ArgumentException
#           end
#         rescue
#           retry
#         end
#       end
#   end


# def p_code
#   p_code = browser.div(class: 'f-forms__element').input
#   return p_code
# end

def date_entry
  date_field_day_v2.send_keys Time.now.day
  date_field_month_v2.send_keys Time.now.month
  date_field_year_v2.send_keys (Time.now.year + 1)
end

def checkbox
  checkbox = browser.div(class: 'f-forms__checkbox')
  return checkbox
end


def fill_form
  details = EnvConfig.data['publications_data']['details']
  postcode_field_v2.send_keys(details['postcode'])
  continue
  continue
  date_entry
  browser.divs(class: 'f-forms__checkbox ')[0].label.scroll.to :center
  sleep 0.5
  browser.divs(class: 'f-forms__checkbox ')[0].label.click
  continue
  sleep 0.5
  dropdown_select
  fnev2_details(details['fn'], details['ln'], details['email'], details['telephone'])
  continue
  fnev2_address(details['a1'], details['a2'], details['towncity'])
  continue
  checkbox.scroll.to :center
  sleep 0.5
  checkbox.label.click
  continue
  checkbox.scroll.to :center
  sleep 0.5
  checkbox.label.click
  continue
  radio_yes_no("No")
  continue
  gdpr_field_v2
  continue
  continue
end

def fnev2_details(firstname, lastname, email, telephone)
  firstname_field_v2.send_keys firstname
  lastname_field_v2.send_keys lastname
  browser.input(name: "EmailAddress").send_keys email
  browser.input(name: "PhoneNumber").send_keys telephone
end

def fnev2_address(a1, a2, towncity)
    browser.a(class: 'show-container-trigger').click
    address1_field_v2.send_keys a1
    address2_field_v2.send_keys a2
    city_field_v2.send_keys towncity
end

# def gdpr_field_v2
#   gdpr_field = browser.fieldset(class: "f-forms__gdpr")
#   gdpr_field.scroll.to :top
#   sleep 1
#   gdpr_field.inputs.each do |i|
#     if i.attribute_value('id').include? "no"
#       i.click
#     end
#   end
# end

#figure out regex
def journey_fin
  sleep 0.5
  raise unless browser.span(class: 'is-editable-field').ps[2].text.include? "Your booking reference number:"
  raise unless browser.title == "Thank you"
end







end
