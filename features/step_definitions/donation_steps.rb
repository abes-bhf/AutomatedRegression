Given /^I navigate to the Donation page$/ do
  TestBrowser.donation_page.visit
end

Given /^I navigate to a campaign page$/ do
  TestBrowser.rosco_page.visit
end

Then /^the Donation page is displayed$/ do
  raise unless TestBrowser.donation_page.on_page?
end

Given /^I select a one-off donation preset$/ do
  @@donation_type = "One-off"
  TestBrowser.donation_page.select_donation('one-off')
end

Given("I select a one-off campaign donation preset") do
  @@donation_type = "One-off campaign"
  TestBrowser.rosco_page.select_donation("one-off")
end

Given("I select a monthly campaign donation preset") do
  @@donation_type = "Monthly campaign"
  TestBrowser.rosco_page.select_donation("monthly")
end

Given ("I select a monthly donation preset") do
  @@donation_type = "Monthly"
  TestBrowser.donation_page.select_donation("monthly")
end

Then /^I am taken to the first page of the donation form$/ do
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
  @@donation_type = "One-off PayPal"
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
    case @@donation_type
      when "One-off"
        @@donation_reference = TestBrowser.browser.url.split("=")[2][16..51]
        @@donation_amount =  '%.2f' % (TestBrowser.browser.url.split("paymentAmount=")[1][0..3].to_i/100)
      when "Monthly"
        @@donation_amount =  '%.2f' % (TestBrowser.browser.url.split("=")[3].to_i/100)
    end
    open(File.join(Dir.pwd, 'submissions/donations.txt'), 'a') do |f|
      f << "> #{@@donate_email} - #{@@donation_type} donation submitted on #{@@ENV} at #{Time.now}\n"
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

Then /^the donate form should refresh with blank validation messages$/ do
  raise("Validation messages not matching expected list") unless TestBrowser.donate_form.validation_present?('blankdp', 'blankname', 'blankaddress', 'blankemail')
end

Then /^the direct debit form should refresh with blank validation messages$/ do
  raise("Validation messages not matching expected list") unless TestBrowser.monthly_payment_form.validation_present?('blankdirectdebit')
end

Then ("the one-off payment form should refresh with blank validation messages") do
  raise("Validation messages displayed do not expected list") unless TestBrowser.donate_form.validation_present?('blankdp', 'blankname', 'blankaddress', 'blankemail')
end

When /^I return to the payment page$/ do
  binding.pry
  if @@donation_type == "One-off"
    TestBrowser.worldpay_page.cancel
  else
    TestBrowser.pay_pal_page.cancel
  end
end

Given /^I answer no to the GiftAid question$/ do
  TestBrowser.single_payment_page.gift_aid(true)
end

Given /^I press continue after filling in invalid details$/ do
  TestBrowser.donate_form.invalid_fill_form('single_donation')
end

Then /^The donate form should refresh with validation messages$/ do
  raise("Validation messages displayed do not expected list") unless TestBrowser.donate_form.validation_present?('invalidname', 'invalidemail', 'invalidpostcode', 'invalidtelephone')
end

Then /^I press continue after filling in invalid direct debit details$/ do
  TestBrowser.monthly_payment_form.invalid_account_details
end

Then /^The direct debit form should refresh with validation messages$/ do
  raise("Validation messages displayed do not expected list") unless TestBrowser.donate_form.validation_present?('ddmustbenumber')
end

Given /^I enter a valid postcode into the postcode lookup field$/ do
  TestBrowser.donate_form.fill_postcode("NW18AW")
end

Given /^I click the Find Address button$/ do
  TestBrowser.donate_form.search_postcode
end

Given /^I select an address from the list of matching addresses$/ do
  TestBrowser.donate_form.select_address
end

Then /^Address fields are shown with the address filled in$/ do
  TestBrowser.donate_form.address_check("NW18AW")
end
