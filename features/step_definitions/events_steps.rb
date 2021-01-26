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
  TestBrowser.event_payment_page.select_paypal
end

And /^I decide to pay for registration through WorldPay$/ do
  TestBrowser.event_payment_page.select_worldpay
end

Given('I navigate to the kew gardens 10k run without logging in') do
  TestBrowser.events_run_page.visit
end

Given('I register for kew gardens with a new email and password') do
TestBrowser.events_run_form.new_registration
end

And /^I fill in run event specific questions$/ do
  TestBrowser.events_run_form.fill_details_p2
end

Then /^I am taken to the event confirmation page$/ do
  er_count = 0
  begin
    TestBrowser.event_confirmation_page.on_page?
    TestBrowser.logging.write_to_file('eventregistration')
  rescue
    retry if (er_count +=1) < 3
  end






end
