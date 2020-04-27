class DyotForm < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/fundraise/dyot/get-started"
    @continue = browser.button(value: 'Submit')
  end

  def trait
    trait = browser.h1(text: 'Your details')
    return trait
  end

  def fill_form
    details = EnvConfig.data['dyot']
    over_16
    get_via_email
    user_details(details['details'])
    binding.pry
    address(details['address'])
    gdpr_field_v2
    continue
  end

  def over_16
    sleep(1)
    browser.div(class: "f-forms__checkbox").scroll.to
    sleep(1)
    browser.div(class: "f-forms__checkbox").click
    continue
  end

  def get_via_email
    browser.label(for: "f-forms__radio__e1548700-f572-4783-a6e1-caefdfdf9ffb").click
    continue
  end

  def user_details(details)
    email = browser.text_field(:id, "f-forms__element-input__5900b8ac-2e60-48bc-a6ab-2a61239166e4")
    title = browser.select(id: "f-forms__element-select__adac7cc7-d992-4354-8055-4f573fc7facb")
    firstname = browser.text_field(:id, "f-forms__element-input__49dae068-d05d-4eeb-8190-c6ea70e16ee9")
    lastname = browser.text_field(:id, "f-forms__element-input__71ba5613-0c87-4ccb-a6d9-47deea08a9c6")
    sendkeys!(email, @@disposable_email)
    sendkeys!(firstname, details['firstname'])
    sendkeys!(lastname, details['lastname'])
    dropdownselect(title, random_title)
    continue
  end

  def address(address)
    postcode = browser.text_field(:id, "f-forms__element-input__572b0801-8673-43f2-b2dc-babba616043e")
    a1 = browser.text_field(:id, "f-forms__element-input__bd6cbef8-6f02-4e74-9987-29c74e132c5e")
    a2 = browser.text_field(:id, "f-forms__element-input__60714416-8346-423d-b37e-d8a7696847ac")
    towncity = browser.text_field(:id, "f-forms__element-input__aab43cae-e15b-47eb-a7a3-7532fa46d846")
    sendkeys!(postcode, address['postcode'])
    sendkeys!(a1, address['a1'])
    sendkeys!(a2, address['a2'])
    sendkeys!(towncity, address['towncity'])
    continue
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
