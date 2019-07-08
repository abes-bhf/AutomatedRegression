class HCForm < GenericForm

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "shop/donating-goods/f-and-e-clearance"
    @continue = browser.input(id: 'main_0_pagecontent_1_btnSubmit')
  end

  def trait
    trait = browser.h1(text: 'House clearance request')
    return trait
  end

  def fill_form
    details = EnvConfig.data['hc']
    title_dropdown = browser.select(id: 'main_0_pagecontent_1_ddlPersonTitle')
    telephone = browser.input(id: 'main_0_pagecontent_1_txtDayTimePhone')
    email = browser.input(id: 'main_0_pagecontent_1_txtEmailAddress')
    howdidyouhear = browser.select(id: 'main_0_pagecontent_1_ddlHowDidYouHearAboutUs')
    howdyouhearchoice = EnvConfig.data['hc_how_did_you_hear']['options'].sample
    additionalquestion = browser.select(id: 'main_0_pagecontent_1_ddlAdditionalQuestion')
    additionalanswer = EnvConfig.data['reason_for_requesting']['options'].sample
    dropdownselect(title_dropdown, random_title)
    fill_name2(details['fn'],details['ln'])
    postcode_lookup(details['postcode'])
    sendkeys!(telephone, details['telephone'])
    sendkeys!(email, details['email'])
    dropdownselect(howdidyouhear, howdyouhearchoice)
    dropdownselect(additionalquestion, additionalanswer)
    data_protection(details['dpemail'],details['dptext'],details['dppost'],details['dptel'])
    binding.pry
    # continue
  end


end
