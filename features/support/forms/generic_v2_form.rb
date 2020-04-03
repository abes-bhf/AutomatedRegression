class GenericV2Form < GenericForm

  def initialize(browser)
    super
  end

  def find_trait
    @trait = browser.div(class: 'order-ref-number')
  end

  def on_page?
    begin
      find_trait
      @trait = trait
      #consider adding a URL check here
      Watir::Wait.until { @trait.exists? && @trait.present? }
      return true
    rescue
      return false
    end
  end

  def validation_message_count(number)
    sleep(1)
    validation_summary = browser.uls(class: "filled")
    return validation_summary.size == number
  end

#  def invalid_email(email)
#    browser.input(name: 'Email')#.to_subtype.clear_inputs
#  end



end
