class EventsPage < GenericPage

  attr_accessor :url, :trait

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "how-you-can-help/events/"
  end

  def trait
    trait = browser.h1(text: 'Take part in an event')
    return trait
  end

  def select_category(category)
    binding.pry
  end


end
