class SearchResultsPage < GenericPage

  attr_accessor :url, :trait

  def initialize(browser)
    super
  end

  def trait
    trait = browser.h1(text: 'Search')
    return trait
  end

  def results
    results = browser.div(class: ['list-results', 'list-results-constrained'])
    return results
  end

end
