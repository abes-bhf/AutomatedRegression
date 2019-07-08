class LondonToBrightonRegistration2 < GenericForm

  def initialize(browser)
    super
    @continue = browser.input( id: "main_0_pagecontent_0_eventreg2_0_uxSubmitBtn")
  end

  def trait
    trait = browser.h2(text: 'Event specific questions')
    return trait
  end

  def fill_details
    values = EnvConfig.data['radios']
    answers = EnvConfig.data['event_specific_answers']
    v = []
    values.each do |key, value|
      radio_selector_by_value(value)
    end
    next_of_kin_name = browser.input(id: 'ux42504bc4-8b81-48d5-a178-835104b3cecb')
    next_of_kin_relation = browser.input(id: 'ux8cc27851-dc55-4740-b861-b747c6234580')
    next_of_kin_number = browser.input(id: 'ux16c3d25f-80a2-4a6e-8bdc-c42eccc5a3b2')
    fundraising_target = browser.input(id: 'uxa496e56d-38e6-41b6-a4e9-1fb77eb94317')
    insurance_agreement = browser.checkbox(value: '3cee98c7-0e83-4892-ae67-d15e8f70d4c5')
    helmet_agreement = browser.checkbox(value: 'cf5efcae-0fa9-416c-b56f-f6324bd172bd')
    terms_and_conditions = browser.checkbox(id: 'main_0_pagecontent_0_eventreg2_0_chkTandCs')
    photo_question = browser.select(id: 'ux83dabcff-b2bf-407b-95ce-696f9cdae082')
    sendkeys!(next_of_kin_name, answers['next_of_kin_name'])
    sendkeys!(next_of_kin_relation, answers['next_of_kin_relation'])
    sendkeys!(next_of_kin_number, answers['next_of_kin_number'])
    sendkeys!(fundraising_target, answers['fundraising_target'])
    # binding.pry
    # insurance_agreement.scroll.to
    # insurance_agreement.set
    # helmet_agreement.scroll.to
    # helmet_agreement.set
    terms_and_conditions.scroll.to
    terms_and_conditions.set
    continue
  end

end
