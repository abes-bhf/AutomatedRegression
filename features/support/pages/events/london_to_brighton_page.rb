class LondonToBrightonPage < GenericPage

  attr_accessor :url, :trait

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/events/bike-rides/london-to-brighton-bike-ride-2020"
  end

  def trait
    trait = browser.h1(text: 'My Account')
    return trait
  end

  def guest_sign_up
    binding.pry
    if logout_button.present?
      log_out
      signupbutton = browser.a(text: 'Sign up')
      signupbutton.click
    elsif login_button.present?
      signupbutton = browser.a(text: 'Sign up')
      signupbutton.click
      guest_continue = browser.a(text: 'CONTINUE')
      guest_continue.click!
    else
      raise ("unable to find either a login or logout button which is very strange and probably bad")
    end
  end

end
