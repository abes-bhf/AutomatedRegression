class ContactUsConfirmation < GenericForm

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "what-we-do/contact-us/thank-you-contact-us"
    @continue = browser.input(value: "Submit")
  end

  def trait
    trait = browser.h1(text: 'Thank you!')
    return trait
  end

end
