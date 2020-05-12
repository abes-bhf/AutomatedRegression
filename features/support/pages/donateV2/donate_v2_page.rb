class DonateV2Page < GenericPage

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/donate/donation/get-started"
    @continue = browser.input(type: 'submit')
    @singletab = browser.input(id: 'monthly-donation')
    @monthlytab = browser.input(id: 'single-donation')
  end

  def trait
    trait = browser.a(text: "Donation Checkout")
    return trait
  end


end 
