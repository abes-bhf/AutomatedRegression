class MyAccountPage < GenericPage

  attr_accessor :url, :trait

  def initialize(browser)
    super
  end

  def trait
    trait = browser.h1(text: 'My Account')
    return trait
  end

end
