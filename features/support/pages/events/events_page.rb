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

  def categories
    event_categories = browser.lis(class: 'eventsTab')
    return event_categories
  end

  def select_category(category)
    tabs = categories
    tabs.each do |tab|
      if tab.text.downcase == category.downcase
        tab.a.click!
      end
    end
  end


end
