Given /^I navigate to the events page$/ do
  TestBrowser.events_page.visit
  raise unless TestBrowser.events_page.on_page?
end

And /^I select bike rides$/ do
  TestBrowser.events_page.select_category('bike rides')
end

And /^I register for L2B with a new email and password$/ do
  TestBrowser.london_to_brighton_registration1.new_registration
end

And /^I decide to pay for registration through PayPal$/ do
  binding.pry
  TestBrowser.event_payment_page.select_paypal
end

And /^I decide to pay for registration through WorldPay$/ do
  TestBrowser.event_payment_page.select_worldpay
end

Then /^I am taken to the event confirmation page$/ do
  if TestBrowser.event_confirmation_page.on_page?
    open(File.join(Dir.pwd, 'submissions/events.txt'), 'a') do |f|
      f << "> #{@@new_acc_email} registered on #{@@ENV} at #{Time.now} \n"
    end
  else
    binding.pry
    raise
  end
end
