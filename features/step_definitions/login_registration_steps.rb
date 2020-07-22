Then /^I am taken to the login registration page$/ do
  raise("Yeah this isn't the login registration page") unless TestBrowser.login_register_page.on_page?
end

Given /^I am on the login registration page$/ do
  TestBrowser.login_register_page.visit
end

And /^I click register$/ do
  TestBrowser.login_register_page.register
end

Then /^I am taken to the registration form$/ do
  raise unless TestBrowser.registration_form.on_page?
end

Given /^I fill in the registration form$/ do
  TestBrowser.registration_form.fill_form
end

Then /^I am taken to the account creation confirmation screen$/ do
  if TestBrowser.registration_confirmation_page.on_page?
    TestBrowser.logging.write_to_file('accountcreation')
  else
    raise("Unable to reach account creation confirmation page")
  end
end

Given /^I am logged in$/ do
  raise('Expected user to be logged in but this is not the case') unless TestBrowser.generic_page.logout_button.present?
end

When /^I log out$/ do
  TestBrowser.generic_page.log_out
  raise ('login button not found, you might not be logged out') unless TestBrowser.generic_page.logout_button != nil
end

Then /^I can log in with the details used in registration$/ do
  TestBrowser.generic_page.log_in
  TestBrowser.login_register_page.login
  raise ('logout button not found, you may not actually belogged in') unless TestBrowser.generic_page.logout_button != nil
end

Then /^I am on my account page$/ do
  TestBrowser.my_account_page.on_page?
end

Given /^I navigate to the L2B registration form without logging in$/ do
  # TestBrowser.london_to_brighton_page.login_visit
  TestBrowser.london_to_brighton_page.visit
  TestBrowser.london_to_brighton_page.guest_sign_up
  raise("Failed to access L2B form") unless TestBrowser.london_to_brighton_registration1.on_page?
end

And /^I enter the email used in registration$/ do
  TestBrowser.london_to_brighton_registration1.fill_email2(@@new_acc_email)
end

And /^I am prompted to log in to the account associated with the email$/ do
  raise unless TestBrowser.london_to_brighton_registration1.email_recognised?
end

And /^I fill in in the registration form with valid details$/ do
  TestBrowser.london_to_brighton_registration1.fill_details
end

Then /^I am taken to the event specific questions page$/ do
  raise unless TestBrowser.london_to_brighton_registration2.on_page?
end

And /^I click login when prompted$/ do
  TestBrowser.london_to_brighton_registration1.login_now
end

Then /^I can log in$/ do
  TestBrowser.login_register_page.login
end

And /^I am taken to a pre-populated registration form that can be submitted once complete$/ do
  TestBrowser.london_to_brighton_registration1.prepopulated_submission
  raise unless TestBrowser.london_to_brighton_registration2.on_page?
end

And /^I fill in event specific questions$/ do
  TestBrowser.london_to_brighton_registration2.fill_details
end

Then /^I am taken to the events payment page$/ do
  raise unless TestBrowser.event_payment_page.on_page?
end

Then /^I return to the event payment page$/ do
  TestBrowser.pay_pal_page.cancel
end

And /^I click login without filling in details$/ do
  TestBrowser.login_register_page.click_login
end

Then /^The login page should refresh with blank validation messages$/ do
  raise("Validation messages not matching expected list") unless TestBrowser.login_register_page.validation_message_count(2)
end

Then /^The login page should refresh with an email validation message$/ do
  raise("Validation messages not matching expected list") unless TestBrowser.login_register_page.validation_message_count(1)
end

Then /^The login page should refresh with a password validation message$/ do
  raise("Validation messages not matching expected list") unless TestBrowser.login_register_page.password_validation?
end

And /^I click login with an invalid email$/ do
  TestBrowser.login_register_page.invalid_email_login
end

And /^I click login with an invalid password$/ do
  TestBrowser.login_register_page.invalid_password_login
end

Then /^The registration form should refresh with blank validation messages$/ do
  raise("Validation messages not matching expected list") unless TestBrowser.login_register_page.validation_message_count(14)
end

Then /^I register with invalid details$/ do
  TestBrowser.registration_form.invalid_fill_form
end

Then /^The registration form should refresh with validation messages$/ do
  raise("Validation messages not matching expected list") unless TestBrowser.login_register_page.validation_message_count(7)
end
