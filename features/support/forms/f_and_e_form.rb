class FAndEForm < GenericForm

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "shop/donating-goods/f-and-e-collection"
    @continue = browser.input(id: 'main_0_pagecontent_1_btnSubmit')
  end

  def trait
    trait = browser.h1(text: 'Furniture and electrical collection')
    return trait
  end

  def fill_form
    details = EnvConfig.data['f_and_e']
    title_dropdown = browser.div(class: 'scfShortDropList').select
    first = browser.text_field(id: 'main_0_pagecontent_1_txtFirstName')
    last = browser.text_field(id: 'main_0_pagecontent_1_txtSurname')
    telephone = browser.text_field(id: 'main_0_pagecontent_1_txtDayTimePhone')
    email = browser.text_field(id: 'main_0_pagecontent_1_txtEmailAddress')
    firelabels = browser.checkbox(id: 'main_0_pagecontent_1_ReadInfoOnFireLabels')
    maybedeclined = browser.checkbox(id: 'main_0_pagecontent_1_UnderstandItemMayBeReclined')
    firstchoice = browser.text_field(id: 'main_0_pagecontent_1_txtFirstChoice')
    howdidyouhear = browser.select(id: 'main_0_pagecontent_1_ddlHowDidYouHearAboutUs')
    howdyouhearchoice = EnvConfig.data['f_and_e_how_did_you_hear']['options'].sample
    dropdownselect(title_dropdown, random_title)
    sendkeys!(first, details['fn'])
    sendkeys!(last, details['ln'])
    fne_address(details)
    sendkeys!(telephone, details['telephone'])
    sendkeys!(email, details['email'])
    firelabels.set
    maybedeclined.set
    sendkeys!(firstchoice, Time.now.strftime("%d/%m/#{Time.now.year+1}"))
    dropdownselect(howdidyouhear, howdyouhearchoice)
    data_protection(details['dpemail'],details['dptext'],details['dppost'],details['dptel'])
    continue
  end

  def fne_address(details)
    postcode = browser.text_field(id: 'main_0_pagecontent_1_txtPostcode')
    address1 = browser.text_field(id: 'main_0_pagecontent_1_txtAddressLine1')
    address2 = browser.text_field(id: 'main_0_pagecontent_1_txtAddressLine2')
    address3 = browser.text_field(id: 'main_0_pagecontent_1_txtAddressLine3')
    towncity = browser.text_field(id: 'main_0_pagecontent_1_txtTownOrCity')
    sendkeys!(postcode, details['postcode'])
    sendkeys!(address1, details['a1'])
    sendkeys!(address2, details['a2'])
    sendkeys!(address3, details['a3'])
    sendkeys!(towncity, details['towncity'])
  end

end
