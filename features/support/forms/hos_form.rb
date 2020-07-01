class HosForm <GenericV2Form

  def initialize(browser)
    super
    @url =EnvConfig.base_url + "how-you-can-help/fundraise/heartofsteel"
    @continue = browser.button(text: "Continue")
  end

  def select_over_sixteen
    #over_sixteen = browser.div(class: 'f-forms__checkbox ').label
    checkbox.click!
    continue
  end

  def engraving_details
    sleep 2
    add_engraving = browser.div(class: 'cta-label')
    add_engraving.scroll.to :center
    sleep 1
    add_engraving.click
    sleep 1
    browser.input(class: 'engraving-name').send_keys "TEST"
    browser.input(id: 'f-forms__element-date__day').send_keys "01"
    browser.input(id: 'f-forms__element-date__month').send_keys "01"
    browser.input(id: 'f-forms__element-date__year').send_keys "1990"
  end

  def enter_engraving_details
    engraving_details
    continue
  end

end
