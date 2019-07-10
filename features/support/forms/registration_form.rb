class RegistrationForm < GenericForm

  def initialize(browser)
    super
    @url = EnvConfig.base_url
    @continue = browser.input( id: "main_0_form_025CB13F9D3A44D9B169619ED3D691C1_form_025CB13F9D3A44D9B169619ED3D691C1_submit")
  end

  def trait
    trait = browser.h1(text: 'Register')
    return trait
  end

  def fill_form
    fill_email(@@new_acc_email)
    fill_password
    select_title(random_title)
    fill_name1('AutoReg FN', 'AutoReg LN')
    postcode_lookup('NW18AW')
    fill_telephone('0987654321')
    data_protection('no', 'no', 'no', 'no')
    continue
  end

end
