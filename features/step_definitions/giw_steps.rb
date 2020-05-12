Given("I navigate to the Gift in wills page") do
  TestBrowser.giw_page.visit
end

Given("I select request your guide") do
  TestBrowser.giw_page.request
end

Given("I select continue") do
  TestBrowser.giw_form.continue
end

Given("I am taken to your details page of the gift in wills form") do
  raise unless TestBrowser.giw_form.on_page?
end

Given("I select continue without filling details") do
  TestBrowser.giw_form.continue
end

Then("the gift in wills form should return with validation messages") do
  raise("unable to find the right amount of validation") unless TestBrowser.giw_form.validation_message_count(5)
  sleep 2
end
#---------------------------------

And("I press continue after filling in invalid details on your details page")do
  TestBrowser.giw_form.yourdetails_invalid_fill
end

# need to add steps to fill out form correctly so i can get to the next pages for the next steps
#---------------------------------

And ("I navigate to your address page of the gift in wills form") do
  TestBrowser.giw_form.yourdetails_valid_fill
end

And ("validation fires when incorrect address details are entered") do
  TestBrowser.giw_form.youraddress_invalid_fill
end

#------------------------------------

And("I navigate to the gdpr page of the gift in wills form") do
  TestBrowser.giw_form.youradress_valid_fill
end

And("I select continue without filling in gdpr") do
  TestBrowser.giw_form.submit_gdpr
end

#Then("the gift in wills form should return with validation messages") do
#  raise("unable to find the right amount of validation") unless TestBrowser.giw_form.validation_message_count(5)
#end

And("I select continue after filling in gdpr") do
  TestBrowser.giw_form.happy_path
end

Then("I am taken to the giw confirmation page") do
  TestBrowser.giw_confirmation_page.on_page?
end

Then("I can download gift in wills guide") do
  TestBrowser.giw_confirmation_page.download
end

#------------------------------------


#Given("I select continue without filling in details") do
#  pending # Write code here that turns the phrase above into concrete actions
#end

#Given("I select continue after filling in gdpr") do
#  pending # Write code here that turns the phrase above into concrete actions
#end

#Then("I can download gift in wills guide") do
#  pending # Write code here that turns the phrase above into concrete actions
#end
