# TestBrowser.browser = Watir::Browser.new (:chrome).to_sym
# TestBrowser.browser.window.maximise
# TestBrowser.browser = Watir::Browser.new (ENV['BROWSER'] || 'chrome').to_sym
# consider for invalid session id : add option --enable-features=NetworkService,NetworkServiceInProcess ---  not seeming to work , 'disable-features=NetworkService' didnt work, need to be connected to vpn
# frequent handshake errors: For Chrome, you need to add --ignore-certificate-errors and --ignore-ssl-errors ChromeOptions() argument: -- mostly working
args = ['--ignore-certificate-errors', '--ignore-ssl-errors', '--no-sandbox']
Before do |scenario|
  TestBrowser.browser = Watir::Browser.new (ENV['BROWSER'] || 'chrome').to_sym, options: {options: {'useAutomationExtension' => false}, :args => args}
  TestBrowser.browser.windows.first.use
  TestBrowser.browser.window.maximize
  @@new_acc_email = "#{SecureRandom.hex 8}@mailsac.com"
  @@disposable_email = "#{SecureRandom.hex 8}@mailsac.com"
  @@donate_email = "#{SecureRandom.hex 8}@mailsac.com"
  @@new_giw_email = "#{SecureRandom.hex 8}@mailsac.com"
  @@cookiecount = 0
  FileUtils.mkdir_p('submissions' ) unless File.directory?('submissions' )
  if ENV['CONFIG'] == nil
    @@ENV = 'integration'
  else
    @@ENV = ENV['CONFIG']
  end
end

After do |scenario|
  begin
    count = 0
    TestBrowser.browser.cookies.clear
    TestBrowser.browser.driver.manage.delete_all_cookies
    TestBrowser.browser.close
    TestBrowser.clear_pages
  rescue Net::ReadTimeout
    retry if (count += 1) < 4
  end
  

end
