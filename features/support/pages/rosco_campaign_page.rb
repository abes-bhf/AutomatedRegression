class RoscoPage < DonationPage

  attr_accessor :url, :trait

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "rosco"
    @continue = browser.input(id: 'uxSubmitBtnBottom')
  end

  def trait
    trait = browser.div(class: 'donate-tabs')
    return trait
  end

  def select_donation(type)
      @oneofftab = browser.a(id: "lnkOneOff")
      @monthlytab = browser.li(id: "liRegularBottom").a
    if type == "one-off"
      @oneofftab.scroll.to
    elsif type =="monthly"
      @monthlytab.click!
      @continue = browser.input(id: 'uxSubmitBtn1Bottom')
    end
    presets = []
    browser.div(class: 'dnt-fig').as.each do |preset|
      presets << preset
    end
    presets.sample.click!
    continue

  #   @three = browser.a(class: "donate-amount-widget", text: "£3")
  #   @ten = browser.a(class: "donate-amount-widget", text: "£10")
  #   if type == "one-off"
  #     @fifteen = browser.a(class: "donate-amount-widget", text: "£15")
  #     @oneofftab.scroll.to
  #     if amount == 10
  #       click!(@ten)
  #       continue
  #     else
  #       raise
  #     end
  #   elsif type == "monthly"
  #     @continue = browser.input(id: 'uxSubmitBtn1Bottom')
  #     @five = browser.a(class: "donate-amount-widget", text: "£5")
  #     @monthlytab.click!
  #     if amount == 10
  #       @ten.click!
  #       continue
  #     end
  #   else
  #   end
  end



end
