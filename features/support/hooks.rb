# TestBrowser.browser = Watir::Browser.new (:chrome).to_sym
# TestBrowser.browser.window.maximise
# TestBrowser.browser = Watir::Browser.new (ENV['BROWSER'] || 'chrome').to_sym
# consider for invalid session id : add option --enable-features=NetworkService,NetworkServiceInProcess
# frequent handshake errors: For Chrome, you need to add --ignore-certificate-errors and --ignore-ssl-errors ChromeOptions() argument:
Before do |scenario|
  TestBrowser.browser = Watir::Browser.new (ENV['BROWSER'] || 'chrome').to_sym, options: {options: {'useAutomationExtension' => false}}
  TestBrowser.browser.windows.first.use
  TestBrowser.browser.window.maximize
  @@new_acc_email = "#{SecureRandom.hex 8}@mailsac.com"
  # @@new_acc_email = "9256667b1139c660@test.co.uk"
  @@donate_email = "#{SecureRandom.hex 8}@mailsac.com"
  @@new_giw_email = "#{SecureRandom.hex 8}@mailsac.com"
  if ENV['CONFIG'] == nil
    @@ENV = 'integration'
  else
    @@ENV = ENV['CONFIG']
  end
end

After do |scenario|
  TestBrowser.browser.cookies.clear
  TestBrowser.browser.driver.manage.delete_all_cookies
  TestBrowser.browser.close
  TestBrowser.clear_pages
end
