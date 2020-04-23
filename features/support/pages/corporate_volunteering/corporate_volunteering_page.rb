class CorporateVolunteeringPage < GenericPage

  attr_accessor :trait, :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/volunteer/get-your-company-volunteering"
  end



  def trait
    trait = browser.h1(itemprop: 'headline', text: "Beat heartbreak forever")
    return trait
  end



  def enquire_link
    enquire_link = browser.a(text: 'Enquire now')
    return enquire_link
  end


  def enquire_link_click
    enquire_link.scroll.to :bottom
    count = 0
    Watir::Wait.until {enquire_link.present?}
        begin
          retries ||= 0
          enquire_link.click
        rescue Selenium::WebDriver::Error::ElementClickInterceptedError
          retry if (retries += 1) < 3
        end
  end




end
