class HouseClearanceLandingPage < GenericPage

  attr_accessor :trait, :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "shop/donating-goods/house-clearance"
  end



  def trait
    trait = browser.h1(itemprop: 'headline', text: "Beat heartbreak forever")
    return trait
  end


  def postcode_field_v2
    postcode_field_v2 = browser.input(name: /^*Postcode$/)
    return postcode_field_v2
  end

  def submit_postcode
    details = EnvConfig.data['formsV2_data']['formsV2_details']
    Watir::Wait.until {postcode_field_v2.present?}
        begin
          retries ||= 0
          postcode_field_v2.send_keys ("XX1 1XX")
        rescue Selenium::WebDriver::Error::ElementClickInterceptedError
          retry if (retries += 1) < 3
        end
    Watir::Wait.until {browser.div(class: "is-cta").button.present?}
        begin
          retries ||= 0
          browser.div(class: "is-cta").button.click
        rescue Selenium::WebDriver::Error::ElementClickInterceptedError
          retry if (retries += 1) < 3
        end
  end




end
