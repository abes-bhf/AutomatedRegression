Given /^I navigate to the Donation page$/ do
  TestBrowser.donation_page.visit
end

Given /^I navigate to a campaign page$/ do
  TestBrowser.rosco_page.visit
end

Then /^the Donation page is displayed$/ do
  raise unless TestBrowser.donation_page.on_page?
end

Given /^I select a donation preset$/ do
  @@donationtype = "One-off"
  TestBrowser.donation_page.select_donation('one-off')
end

Given("I select a one-off campaign donation preset") do
  @@donationtype = "One-off campaign"
  TestBrowser.rosco_page.select_donation("one-off")
end

Given("I select a monthly campaign donation preset") do
  @@donationtype = "Monthly campaign"
  TestBrowser.rosco_page.select_donation("monthly")
end

Given ("I select a monthly donation preset") do
  @@donationtype = "Monthly"
  TestBrowser.donation_page.select_donation("monthly")
end

Then /^I am taken to the first page of the one-off donation form$/ do
  raise unless TestBrowser.donate_form.on_page? # Write code here that turns the phrase above into concrete actions
end

And /^I fill in single payment details$/ do
  TestBrowser.donate_form.fill_form('single_donation')
end

And /^I fill in direct debit details$/ do
  TestBrowser.donate_form.fill_form('direct_debit')
end

Then /^I am taken to the one-off payment page$/ do
  raise unless TestBrowser.single_payment_page.on_pg?
end

Then /^I am taken to the monthly payment page$/ do
  raise unless TestBrowser.monthly_payment_form.on_page?
end

Then /^I am taken to the Worldpay page$/ do
  raise unless TestBrowser.worldpay_page.trait.present?
end

When /^I select Donate by credit\/debit card$/ do
  TestBrowser.single_payment_page.select_worldpay # Write code here that turns the phrase above into concrete actions
end

When /^I select Donate by PayPal$/ do
  @@donationtype = "One-off PayPal"
  TestBrowser.single_payment_page.select_paypal # Write code here that turns the phrase above into concrete actions
end

When /^I enter valid card details$/ do
  TestBrowser.worldpay_page.use_valid_card # Write code here that turns the phrase above into concrete actions
end

When /^I enter valid PayPal details$/ do
  TestBrowser.pay_pal_page.login # Write code here that turns the phrase above into concrete actions
end

When /^I enter valid direct debit details$/ do
  TestBrowser.monthly_payment_form.fill_account_details
end

And /^I should be able to select a start date within the next six months$/ do
  TestBrowser.monthly_payment_form.date_choices
end

Then /^I am taken to the confirmation page$/ do
  if TestBrowser.single_confirm_page.on_page?
    open(File.join(Dir.pwd, 'submissions/donations.txt'), 'a') do |f|
      f << "> #{@@email} - #{@@donationtype} donation submitted on #{ENV['CONFIG']} at #{Time.now} \n"
    end
  else
    raise
  end
end

When /^I press continue without filling details$/ do
  TestBrowser.donate_form.continue
end

When /^I press continue without filling direct debit details$/ do
  TestBrowser.monthly_payment_form.continue
end

Then /^the donate form should refresh with validation messages$/ do
  raise unless TestBrowser.donate_form.validation_present?('dp', 'name', 'address', 'email')
end

Then /^the direct debit form should refresh with validation messages$/ do
  raise unless TestBrowser.monthly_payment_form.validation_present?('directdebit')
end

When /^I return to the payment page$/ do
  if @@donationtype == "One-off"
    TestBrowser.worldpay_page.cancel
  else
    TestBrowser.pay_pal_page.cancel
  end
end
