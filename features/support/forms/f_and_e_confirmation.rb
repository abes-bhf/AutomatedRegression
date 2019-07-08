class FAndEConfirmation < GenericForm

  def initialize(browser)
    super
  end

  def trait
    trait = browser.h1(text: 'Thank you for your donation')
    return trait
  end

  def reference
    binding.pry
  end

end
