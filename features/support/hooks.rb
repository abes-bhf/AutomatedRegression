# TestBrowser.browser = Watir::Browser.new (:chrome).to_sym
# TestBrowser.browser.window.maximise
# TestBrowser.browser = Watir::Browser.new (ENV['BROWSER'] || 'chrome').to_sym
TestBrowser.browser = Watir::Browser.new (ENV['BROWSER'] || 'chrome').to_sym, options: {options: {'useAutomationExtension' => false}}
Before do
  TestBrowser.browser.window.maximize
  TestBrowser.browser.cookies.clear
  @@new_acc_email = "#{SecureRandom.hex 8}@mailsac.com"
  # @@new_acc_email = "9256667b1139c660@test.co.uk"
  @@donate_email = "#{SecureRandom.hex 8}@mailsac.com"
  if ENV['CONFIG'] == nil
    @@ENV = 'uat'
  else
    @@ENV = ENV['CONFIG']
  end
end

After do |scenario|
  TestBrowser.browser.driver.manage.delete_all_cookies
end
