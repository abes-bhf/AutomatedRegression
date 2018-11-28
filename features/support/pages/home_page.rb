class HomePage < GenericPage

  attr_accessor :trait, :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url
  end

  def trait
    trait = browser.h1(itemprop: 'headline', text: "Beat heartbreak forever")
    return trait
  end

  def login
    loginregister = browser.a(text: 'LOG IN/REGISTER')
    loginregister.click!
  end



end
