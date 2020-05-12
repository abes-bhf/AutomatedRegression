Given("I navigate to the donate page") do
  TestBrowser.donate_V2_page.visit
end

Given("I select continue without selecting donation type") do
  TestBrowser.donate_V2_page.continue
end

Then("donate widget should return with validation messages") do
  raise("unable to find the right amount of validation") unless TestBrowser.validation_message_count(1)
  sleep 2
end

Given("I enter an invalid amount in other amount") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should be shown error messages") do
  pending # Write code here that turns the phrase above into concrete actions
end


#HAPPYPATH

Given("I select an amount") do
  TestBrowser.donate_v2_form.donate_widget_monthly
end

Given("I fill in details about you") do
  TestBrowser.donate_v2_form.correct_about_you
end

Then("I fill in my address") do
  TestBrowser.donate_v2_form.correct_address
end

Then("I select this is my own money") do
  TestBrowser.donate_v2_form.isthisyourmoney
end

Then("add gift aid") do
  TestBrowser.donate_v2_form.add_giftaid
end

Then("I set up direct debit") do
  binding.pry
end

Then("fill in gdpr") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("select confirm and pay") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I select the donation was in memory and who") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I inform a next of kin") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I add next of kin information") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I add a message") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I add next of kin address") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("finally the confirmation page is presented") do
  pending # Write code here that turns the phrase above into concrete actions
end
