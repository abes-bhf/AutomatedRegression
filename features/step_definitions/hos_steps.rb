
Given("I navigate to the heart of steal page") do
  TestBrowser.hos_page.visit
end

Given("I select I am over sixteen") do
  TestBrowser.hos_form.select_over_sixteen
end

Given("I fill in engraving details") do
  TestBrowser.hos_form.enter_engraving_details
end

Given("I fill in your details") do
  binding.pry 
end

Then("I share my story") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I end up in order summary page") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("add donation") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("proceed to pay") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("am presented with the confirmation page") do
  pending # Write code here that turns the phrase above into concrete actions
end

### END OF HAPPY PATH
