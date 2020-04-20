class MyMarathonConfirmation < GenericV2Form

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "/how-you-can-help/fundraise/my-marathon-form-2020/register/confirmation"
  end

  def trait
    trait = browser.p(text: "Now you've signed up for MyMarathon, it's time to get fundraising!")
    return trait
  end

end
