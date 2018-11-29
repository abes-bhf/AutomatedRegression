class EventConfirmationPage < GenericPage

  attr_accessor :url, :trait

  def initialize(browser)
    super
  end

  def trait
    trait = browser.h2(text: 'Thank you for signing up')
    return trait
  end

end
