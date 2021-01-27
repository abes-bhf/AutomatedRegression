
Given("I navigate to the heart of steel page") do
  TestBrowser.hos_page.visit
end

Given("I select I am over sixteen") do
  TestBrowser.hos_form.select_over_sixteen
end

Given("I fill in engraving details") do
  TestBrowser.hos_form.engraving_details
end

Given("I fill in your details") do
  TestBrowser.hos_form.details_section
end

Then("I share my story") do
  TestBrowser.hos_form.share_my_story
end

Then("fill in gdpr") do
  TestBrowser.hos_form.select_gdpr
end

Then("I end up in order summary page") do
  TestBrowser.hos_form.summary
end

Then("add donation") do
  TestBrowser.hos_form.add_donation
end

Then("add gift aid") do
  TestBrowser.hos_form.add_gift_aid
end

Then("am presented with the hos confirmation page") do
  TestBrowser.hos_form.hos_confirmation
end

### END OF HAPPY PATH
