Given("I navigate to the rcd form") do
  TestBrowser.r_c_d_form.visit
end

Given("I complete the rcd form") do
  TestBrowser.r_c_d_form.fill_form
end

Then("I am taken to the rcd thank you page") do
  TestBrowser.r_c_d_form.journey_fin
end
