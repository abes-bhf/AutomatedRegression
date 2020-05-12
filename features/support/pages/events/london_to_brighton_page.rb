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

  def login_visit
    TestBrowser.browser.goto @url
    if @@ENV == "gateway"
      if browser.button(id:"details-button").present?
        browser.button(id:"details-button").click
        browser.a(id: "proceed-link").click
      end
    end
  end

  def guest_sign_up
    if logout_button.present?
      log_out
      signupbutton = browser.a(text: 'Sign up')
      signupbutton.click
    elsif login_button.present?
      signupbutton = browser.a(text: 'Sign up')
      binding.pry
      signupbutton.click
      guest_continue = browser.a(text: 'CONTINUE')
      guest_continue.click!
    else
      raise ("unable to find either a login or logout button which is very strange and probably bad")
    end
  end

end
