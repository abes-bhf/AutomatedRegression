class JustWalkConfirmation < GenericForm

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/fundraise/just-walk/jw-sign-up/confirmation"
  end

  def trait
    trait = browser.span(text: 'Thank you for joining us to help find the cures and treatments to beat heart and circulatory diseases.')
    return trait
  end

end
