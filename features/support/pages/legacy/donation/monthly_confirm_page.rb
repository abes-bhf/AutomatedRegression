class MonthlyConfirmPage < GenericPage

  attr_accessor :url, :trait

  def initialize(browser)
    super
  end

  def trait
    trait = browser.div(id: 'main_0_pagecontent_0_pnlConfirmation')
    return trait
  end

end
