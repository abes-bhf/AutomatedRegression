class Logging

  attr_accessor :browser

  def initialize(browser)
    @browser = browser
  end

  def donateinfo
    case @@donation_type
      when "One-off"
        @@donation_reference = TestBrowser.browser.url.split("=")[2][16..51]
        @@donation_amount =  '%.2f' % (TestBrowser.browser.url.split("paymentAmount=")[1][0..3].to_i/100)
      when "Monthly"
        @@donation_amount =  '%.2f' % (TestBrowser.browser.url.split("=")[3].to_i/100)
      when "One-off PayPal"
        @@donation_amount =  '%.2f' % (TestBrowser.browser.url.split("=")[2].split("&").first.to_i/100)
    end
    donate_info = "#{@@donation_type} donation of #{@@donation_amount}"
    return donate_info
  end

  def write_to_file(action)
    email = @@new_acc_email
    actioninfo = action
    if action == 'donation'
      email = @@donate_email
      actioninfo = donateinfo
    end
    open(File.join(Dir.pwd, "submissions/#{action}s.txt"), 'a') do |f|
      f << "> #{email} - #{actioninfo} completed on #{@@ENV} at #{Time.now} \n"
    end
  end

end
