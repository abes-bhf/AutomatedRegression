class DyotPage < GenericPage

  attr_accessor :trait, :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/fundraise/do-your-own-fundraising/your-fundraising-pack"
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
    trait = browser.h1(text: "Sign up to raise money")
    return trait
  end


end
