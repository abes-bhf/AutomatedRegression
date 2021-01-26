class HosPage < GenericPage

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/fundraise/heartofsteel/order-engraving/get-started"
    @contnue = browser.input(id: 'submit')

  end

  def trait
    trait = browser.a(text: "Heart of steel")
    return trait
  end

end
