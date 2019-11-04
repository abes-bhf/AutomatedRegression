class HomePage < GenericPage

  attr_accessor :trait, :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url
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

  def book_a_collection
    f_and_e = nav.a(class: 'g-nav-primary__button--book')
    f_and_e.click!
  end

  def donate
    # f_and_e = nav.a(class: 'g-nav-primary__button--book')
    # f_and_e.click!
    # # binding.pry
    donatebutton = nav.a(class: 'g-nav-primary__button--donate')
    donatebutton.click!
  end

  def main_headings
    nav = navbottom.as(class: 'g-nav-primary__link')
    level1 = EnvConfig.data['navlinks'].keys
    main_headings = []
    nav.each do |n|
      if level1.include?(n.text)
        main_headings << n
      end
    end
    return main_headings
  end

  def level_two
    leveltwo = browser.div(class: ['g-nav-primary__mega', 'active']).ul(role: "menu").lis
    level2 = EnvConfig.data['navlinks'][@@hovered1].keys
    level_two_links = []
    leveltwo.each do |n|
      if level2.include?(n.text)
        level_two_links << n
      end
    end
    return level_two_links
  end

  def level_three
    level_three_links = []
    levelthree = browser.div(class: ['g-nav-primary__mega--subnav', 'active']).lis
    level3 = EnvConfig.data['navlinks'][@@hovered1][@@hovered2]
    level_three_links = []
    levelthree.each do |l|
      if level3.include?(l.text)
        level_three_links << l
      end
    end
    return level_three_links
  end

  def random_level_one
    links = main_headings
    return links.sample
  end

  def level_two_links
    begin
      leveltwolinks = level_two.last(level_two.size - 1)
    rescue ArgumentError
      binding.pry
    end
    return leveltwolinks
  end

  def random_level_two
    leveltwolinks = level_two_links
    return leveltwolinks.sample
  end

  def random_level_two_with_subitems
    leveltwolinks = level_two_links
    level2 = []
    links_w_subitems = []
    EnvConfig.data['navlinks'][@@hovered1].each do |l|
      if l[1] != nil
        level2 << l[0]
      end
    end
    leveltwolinks.each do |l|
      if level2.include?(l.text)
        links_w_subitems << l
      end
    end
    return links_w_subitems.sample
  end

  def random_level_three
    levelthreelinks = level_three.last(level_three.size - 1)
    return levelthreelinks.sample
  end

  def search_button
    search_button = browser.a(class: 'g-nav-primary__search--control')
    return search_button
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
end
