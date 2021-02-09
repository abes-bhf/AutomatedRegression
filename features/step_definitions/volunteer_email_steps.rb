Given("I am on the volunteer hub page") do
  TestBrowser.volunteering_hub_page.visit
end

When("I click sign me up") do
  TestBrowser.volunteering_hub_page.sign_me_up
end

Then("I am taken to the volunteer email form") do
  TestBrowser.volunteer_email_form.on_page?
end

Given("I navigate to the volunteer email form") do
  TestBrowser.volunteer_email_form.visit
end

Given("I complete the volunteer email form") do
  TestBrowser.volunteer_email_form.fill_form
  TestBrowser.volunteering_email.continue
end

Then("I am taken to the volunteer email confirmation page") do
  TestBrowser.volunteer_email_form.journey_fin
end

Given('I complete the volunteer email form up to the final submission page') do
  TestBrowser.volunteer_email_form.fill_form
end
