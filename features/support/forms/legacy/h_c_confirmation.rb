class HCConfirmation < GenericForm

  def initialize(browser)
    super
  end

  def trait
    trait = browser.h1(text: 'Thank you for your collection request')
    return trait
  end

  def reference
    binding.pry
  end

end
