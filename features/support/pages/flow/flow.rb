class Flow < GenericPage

  def initialize(browser)
    super
    @url = EnvConfig.flow_url
  end

  def trait
    trait = browser.div(class: 'navbar__logo').a(text: 'Flow')
    return trait
  end

  def logo
    logo = browser.div(class: 'navbar__logo').img(alt: 'British Heart Foundation', class: 'hidden-xs')
    return logo
  end

  def on_page?
    begin
      l = logo
      t = trait
      Watir::Wait.until { l.exists? && l.present? }
      Watir::Wait.until { t.exists? && t.present? }
      return true
    rescue
      return false
    end
  end

  def login
    email = browser.input(id: 'Email', name: 'Email')
    pass = browser.input(id: 'Password', name: 'Password')
    sendkeys!(email, EnvConfig.data['flow']['email'])
    sendkeys!(pass, EnvConfig.data['flow']['password'])
    puts('please complete the captcha for ya boy then type exit into the commandline')
    binding.pry
    browser.input(type: 'submit').click!
  end

  def logged_in?
    return browser.a(text: EnvConfig.data['flow']['email']).present?
  end

  def all_shops
    shop_dropdown = browser.a(class:'dropdown-toggle', text:'Head office')
    shop_dropdown.click!
    allshops = browser.a(text: 'All shops')
    allshops.click!
  end

  def searchref(ref)
    searchbar = browser.input(id:'search')
    sendkeys!(searchbar, ref)
    searchbutton = browser.button(type: 'submit')
    searchbutton.click!
  end

  def searchresult(ref)
    results = browser.table(class: 'table').tbody.trs
    results.each do |r|
      if r.tds[1].text == ref
        return r
      end
    end
  end

  def viewresult(ref)
    results = browser.table(class: 'table').tbody.trs
    results.each do |r|
      if r.tds[1].text == ref
        r.tds[5].a(class: 'btn').click!
      end
    end
  end

  def details(ref)
    raise unless browser.url.split('/')[5]==ref.downcase
  end

end
