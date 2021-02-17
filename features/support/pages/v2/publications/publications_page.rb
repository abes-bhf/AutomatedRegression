class PublicationsPage < GenericPage

  attr_accessor :trait, :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "publications"
  end

  def nav
    nav = browser.nav(class: 'g-nav-primary')
    return nav
  end

  def navbottom
    navbottom = nav.ul(class: 'g-nav-primary__bottom')
  end

  def navtop
    navtop = nav.ul(class: 'g-nav-primary__top')
  end

  def trait
    trait = browser.h1(itemprop: 'headline', text: "Beat heartbreak forever")
    return trait
  end

  def login
    loginregister = browser.a(text: 'LOG IN/REGISTER')
    loginregister.click!
  end



  def donate
    donatebutton = nav.a(class: 'g-nav-primary__button--donate')
    donatebutton.click!
  end


  def select_publication
    select_publication = browser.a(text: "Understanding cholesterol")
    select_publication.scroll.to :center
    Watir::Wait.until {select_publication.present? & select_publication.exists?}
    begin
      retries ||= 0
      select_publication.click
      raise unless browser.title == "Understanding cholesterol | BHF"
    rescue
      retry if (retries += 1) < 3
    end
  end

  # def select_publication_zxx
  #   select_publication = browser.a(text: "Understanding vascular dementia")
  #   return select_publication
  # end

  def add_to_basket
    add_to_basket_button = browser.input(id: "main_0_pagecontent_0_btnAddToBasket")#
    begin
      Watir::Wait.until {add_to_basket_button.present?}
    rescue
      select_publication
    end
    add_to_basket_button.scroll.to :center
    begin
      retries ||= 0
    add_to_basket_button.click
    rescue Selenium::WebDriver::Error::ElementClickInterceptedError
      retry if (retries += 1) < 7
    end
  end



  def search_button
    search_button = browser.input(id: 'main_0_pagecontent_0_uxPubSearchBtn')
    return search_button
  end

  def search_results
    search_results = browser.element(class: "list-results")
    return search_results
  end

  def search_count
    search_count = browser.elements(:class => "result").size
    return search_count
  end

  def search_bar
    search_bar = browser.li(class: ['g-nav-primary__search', 'active'])
    return search_bar
  end

  def search(term)
    search_button.click unless search_bar.present?
    search_bar.input(id: 'keyword').send_keys(term)
    search_bar.input(type: 'submit').click
  end

  def decookie
    accept = browser.input(class: ['optanon-allow-all', 'accept-cookies-button'])
    accept.click if accept.present?
    browser.execute_script("bd = document.getElementById('alert-box-title'); bd.parentNode.removeChild(bd);")
  end

end
