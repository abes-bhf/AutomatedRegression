# TestBrowser.browser = Watir::Browser.new (:chrome).to_sym
# TestBrowser.browser.window.maximise
TestBrowser.browser = Watir::Browser.new (ENV['BROWSER'] || 'chrome').to_sym
Before do
  TestBrowser.browser.cookies.clear
  @@email = "#{SecureRandom.hex 8}@test.com"
end

After do |scenario|
  TestBrowser.browser.driver.manage.delete_all_cookies
end
