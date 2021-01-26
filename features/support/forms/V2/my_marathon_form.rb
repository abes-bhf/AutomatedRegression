class MyMarathonForm < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/fundraise/my-marathon-form-2020/register/get-started"
    @continue = browser.button(value: 'Submit')
  end

  def trait
    trait = browser.h1(text: 'Your details')
    return trait
  end

  def fill_form
    details = EnvConfig.data['mymarathon']
    get_started_yes
    mm_details(details['details'])
    address(details['address'])
    gdpr_field_v2
    continue
  end

  def get_started_yes
    browser.input(:value ,"Yes").click
    continue
  end

  def mm_details(details)
    email = browser.text_field(:id, "f-forms__element-input__b1fb9280-9a0e-44d6-abb6-25c0b8e00566")
    firstname = browser.text_field(:id, "f-forms__element-input__49dae068-d05d-4eeb-8190-c6ea70e16ee9")
    lastname = browser.text_field(:id, "f-forms__element-input__71ba5613-0c87-4ccb-a6d9-47deea08a9c6")
    sendkeys!(email, @@disposable_email)
    sendkeys!(firstname, details['firstname'])
    sendkeys!(lastname, details['lastname'])
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

def mm_output_email
  open(File.join(Dir.pwd, 'submissions/my_marathon.txt'), 'a') do |f|
    f << "> #{@@disposable_email} registered on #{@@ENV} at #{Time.now} \n"
  end
end


end
