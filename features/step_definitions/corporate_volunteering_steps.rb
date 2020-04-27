Given("I am on the corporate volunteer enquiries page") do
  TestBrowser.corporate_volunteering_page.visit
end

When("I click enquire now") do
  TestBrowser.corporate_volunteering_page.enquire_link_click
end

Then("I am taken to the corporate volunteer form") do
  TestBrowser.corporate_volunteering_form.on_page?
end

Given("I navigate to the corporate volunteer form") do
  TestBrowser.corporate_volunteering_form.visit
end

Given("I complete the corporate volunteer form") do
  TestBrowser.corporate_volunteering_form.fill_form
end

Given("I navigate to the individual sign up form") do
  TestBrowser.corporate_volunteering_individual_signup_form.visit
end

Given("I complete the corporate volunteer individual sign up form") do
  TestBrowser.corporate_volunteering_individual_signup_form.fill_form
end

Then("I am taken to the enquiry confirmation page") do
  TestBrowser.corporate_volunteering_form.journey_fin
end

Then("I am taken to the individual sign up confirmation page") do
  TestBrowser.corporate_volunteering_individual_signup_form.journey_fin
end
