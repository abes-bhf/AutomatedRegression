class HeartMattersForm < GenericForm

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "informationsupport/heart-matters-subscribe"
    @continue = browser.input(value: "Continue")
  end

  def trait
    trait = browser.h1(text: 'Register')
    return trait
  end

  def fill_form
    fill_email_3(@@new_acc_email)
    fill_password
    select_title(random_title)
    fill_name1a('AutoReg FN', 'AutoReg LN')
    postcode_lookup('WR2 6NJ')
    fill_telephone_2('0987654321')
    data_protection('no', 'no', 'no', 'no')
  end

  def invalid_fill_form
    postcode_lookup('WR2 6NJ')
    fill_email("email")
    invalid_password
    select_title(random_title)
    fill_name1('!£@^&', '123123')
    fill_telephone('telephone')
    data_protection('no', 'no', 'no', 'no')
    fill_postcode('postcode')
    continue
  end

  def address_check
    lookup = EnvConfig['data']['postcodelookup']['WR26NJ']
    address_fields = []
    browser.divs(class: 'scfSingleLineGeneralPanel').each do |i|
      if i.input.present?
        address_fields << i.input
      end
    end
    raise unless address_fields[4].value == lookup['address1']
    raise unless address_fields[5].value == lookup['address2']
    raise unless address_fields[6].value == lookup['address3']
    raise unless address_fields[7].value == lookup['towncity']
    raise unless address_fields[8].value == lookup['county']
  end

  def hm_membership_options
    browser.input(value: "Submit").click
  end

  def hm_journey_fin
    hm_count = 0
    begin
      raise unless browser.h1(text: "Thank you for joining Heart Matters.").present?
    rescue
      retry if (hm_count += 1) < 4
    end
    open(File.join(Dir.pwd, 'submissions/heart_matters.txt'), 'a') do |f|
      f << "> #{@@new_acc_email}} registered on #{@@ENV} at #{Time.now} \n"
    end
  end










end
