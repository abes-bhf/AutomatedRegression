class NewsletterPage < GenericForm

  attr_accessor :url

  def initialize(browser)
    super
    @url = EnvConfig.base_url + "sign-up-to-our-e-newsletter"
    @continue = browser.input(value: "Submit")
  end

  def trait
    trait = browser.h1(text: 'Sign up for email updates')
    return trait
  end

  def fill_form
    firstname = browser.text_field(id: "main_0_form_5CA69DA874A3478FAD4723B30068DA22_field_1500D99D6C0D4911BEABE129BB98360F")
    lastname = browser.text_field(id: "main_0_form_5CA69DA874A3478FAD4723B30068DA22_field_D341F3D479734593AD04B4767E265A11")
    email = browser.text_field(id: "main_0_form_5CA69DA874A3478FAD4723B30068DA22_field_5E7527E6748440B8BC9858E5682521DC")
    sendkeys!(firstname, "AutoNLFN")
    sendkeys!(lastname, "AutoNLLN")
    sendkeys!(email, @@disposable_email)
    browser.table(class: "data-protection-table").radio(value: "rbContactByEmailNo").click!
  end

  def confirmed?
    begin
      confirmation_message = browser.h2(text: "Never miss a beat")
      Watir::Wait.until { confirmation_message.exists? && confirmation_message.present? }
      return true
    rescue
      return false
    end
  end

  def newsletter_output_email
    open(File.join(Dir.pwd, 'submissions/newsletter_signup.txt'), 'a') do |f|
      f << "> #{@@disposable_email} registered on #{@@ENV} at #{Time.now} \n"
    end
  end


end
