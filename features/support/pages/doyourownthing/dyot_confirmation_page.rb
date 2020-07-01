class DyotConfirmationPage < GenericPage

  attr_accessor  :url

  def initialize(browser)
    super
    @url = EnvConfig.publications_url + "confirmation"
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

  def decookie
    accept = browser.input(class: ['optanon-allow-all', 'accept-cookies-button'])
    accept.click if accept.present?
    browser.execute_script("bd = document.getElementById('alert-box-title'); bd.parentNode.removeChild(bd);")
  end

  # def on_page?
  #   trait = browser.div(class: 'order-ref-number').p.text
  #   if trait.size == 8
  #     return true
  #   else
  #     return false
  #   end
  # end
  def find_trait
    @trait = browser.h1(text: 'Order complete')
  end


  def on_page?
    begin
      find_trait
      #consider adding a URL check here
      Watir::Wait.until { @trait.exists? && @trait.present? }
      return true
    rescue
      return false
    end
  end


end
