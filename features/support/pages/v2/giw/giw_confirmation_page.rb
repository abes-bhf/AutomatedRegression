class GiwConfirmationPage < GenericV2Form

  attr_accessor :url


  def find_trait
    @trait = browser.a(text: "Thank you for getting in touch with us")
  end

  def download_now
    download_now = browser.a(text: "Download guide now")
    return download_now
  end

  def download
    download_now.scroll.to :center
    click!(download_now)
  end

end
