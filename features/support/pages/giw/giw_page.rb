class GiwPage < GenericPage

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/leave-a-gift-in-your-will"
    @continue = browser.a(text: "Request your guide")
  end

  def trait
    trait = browser.a(text: "Leave a gift in your Will")
    return trait
  end

  def request_giw
    request_giw = browser.a(text: "Request your guide")
    return request_giw
  end

  def request
    request_giw.click
    #binding.pry
  end


end
