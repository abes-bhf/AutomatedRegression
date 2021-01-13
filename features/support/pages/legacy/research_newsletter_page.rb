class ResearchNewsletterPage < GenericForm

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "what-we-do/our-research/research-newsletter"
    @continue = browser.input(value: "Submit")
  end

  def trait
    trait = browser.h1(text: "Sign up for our research newsletter")
    return trait
  end

  def fill_form
    firstname = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_A4A93621EEC445949C6D02C2DAE1CF6B_field_B40B7FDAEDA8443FA4E8BA3163F65105")
    lastname = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_A4A93621EEC445949C6D02C2DAE1CF6B_field_9E6A910A5E954646B8D1DFACE2B17D40")
    email = browser.text_field(id: "main_0_pagecontent_0_middlecontent_0_form_A4A93621EEC445949C6D02C2DAE1CF6B_field_052C795B039B4F2EBE5D118288537478")
    sendkeys!(firstname, "AutoRNLFN")
    sendkeys!(lastname, "AutoRNLLN")
    sendkeys!(email, @@disposable_email)
    browser.table(class: "data-protection-table").radio(value: "rbContactByEmailNo").click!
    continue
  end

  def confirmed?
    begin
      confirmation_message = browser.div(id: "skipto-content")
      Watir::Wait.until { confirmation_message.exists? && confirmation_message.present? }
      return true
    rescue
      return false
    end
  end

  def research_newsletter_output
    open(File.join(Dir.pwd, 'submissions/research_newsletter.txt'), 'a') do |f|
      f << "> #{@@disposable_email} registered on #{@@ENV} at #{Time.now} \n"
    end
  end


end
