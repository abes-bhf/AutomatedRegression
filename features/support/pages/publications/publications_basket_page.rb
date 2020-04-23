class PublicationsBasketPage < GenericPage

  attr_accessor :trait, :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "basket/my-basket"
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



  def login
    loginregister = browser.a(text: 'LOG IN/REGISTER')
    loginregister.click!
  end

  # def book_a_collection
  #   f_and_e = nav.a(class: 'g-nav-primary__button--book')
  #   f_and_e.click!
  # end

  def preset_donation_amount
    preset_options = ["£2", "£5", "£10", "£20"] # data from a forms 2 or donation yaml?
    return preset_options.sample
  end

  def select_preset_amount(amount)
    @used_value = amount
    donation_section = browser.div(class: 'donate-bar')
    donation_section.scroll.to :center
    donation_options = donation_section.as(class: 'donate-amount')
    sleep 1
    donation_options.each do |option|
      if option.text == amount
        option.click
      end
    end

  end

  def add_donation_button
    add_donation_button = browser.input(id: 'main_0_pagecontent_0_btnAddDonationId')
    return add_donation_button
  end


  def add_preset_donation
    select_preset_amount(preset_donation_amount)
    add_donation_button.click
  end


  def donation_present
    sleep 3
    raise unless browser.h2(text: 'Donation').present?
    #tbc check the donation amount matches what is clicked?
    raise unless browser.tds(class: 'col-unit-price')[1].text == @used_value + ".00"
    #works for 2 items
  end




  def select_publication
    select_publication = browser.a(:text, "Understanding vascular dementia")
    return select_publication
  end

  def add_to_basket
    add_to_basket = browser.input(id: "main_0_pagecontent_0_btnAddToBasket")
    return add_to_basket
  end



  def search_button
    search_button = browser.input(id: 'main_0_pagecontent_0_uxPubSearchBtn')
    return search_button
  end

  def search_results
    search_results = browser.element(:class, "list-results")
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

  def find_trait
    @trait = browser.h1(text: "My basket")
  end


  # def on_page?
  #   # the attempt below is to allow some load time for the trait [5 seconds]
  #   find_trait
  #   # @trait = trait
  #   on_page = @trait.exists? & @trait.present?
  #   count = 0
  #   until count == 5 || on_page
  #     sleep 1
  #     count += 1
  #     puts "Trait check fail #{count}"
  #   end
  #   raise if count == 5
  # end


  def on_page?
    begin
      find_trait
      Watir::Wait.until { @trait.exists? && @trait.present? }
      return true
    rescue
      return false
    end
  end


  def add_more_pub
    count = 0
    publications_quantity = rng_small
    browser.a(class: "quantity-increase").scroll.to :center
    sleep 0.5
    until count == publications_quantity
      browser.a(class: "quantity-increase").click
      count += 1
    end
    browser.input(value: 'Update quantity').click
    sleep 0.5
  end

  def rng_small
    a = 1..5
    b = a.to_a
    return b.sample
  end

  def checkout
    browser.input(value: 'Check out').scroll.to :center
    sleep 0.5
    browser.input(value: 'Check out').click
  end






end
