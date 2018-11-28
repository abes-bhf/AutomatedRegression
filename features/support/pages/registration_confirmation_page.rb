class RegistrationConfirmationPage < GenericPage

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "my-account/your-account-has-been-created"
  end

  def trait
    trait = browser.h1(text: 'Your account has been created')
    return trait
  end

end
