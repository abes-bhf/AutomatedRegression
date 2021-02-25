Given('I navigate to the heart matters page') do
  TestBrowser.heart_matters_page.visit
end

Given('I click join heart matters') do
  TestBrowser.heart_matters_page.join_heart_matters
end

Given('I fill in the heart matters form') do
  TestBrowser.heart_matters_form.fill_email_3(@@new_acc_email)
  TestBrowser.heart_matters_form.fill_form
  TestBrowser.heart_matters_form.continue
end

Then('I am taken to the confirmation page') do
  TestBrowser.heart_matters_form.hm_membership_options
  TestBrowser.heart_matters_form.hm_journey_fin
end

Given('I fill in the heart matters form as an existing user') do
  TestBrowser.heart_matters_form.fill_email_3("DigitalTestTeam@bhf.org.uk")
  TestBrowser.heart_matters_form.fill_form
  TestBrowser.heart_matters_form.continue
end
