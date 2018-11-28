Given("I navigate to the Homepage") do
  TestBrowser.home_page.visit
end

Then("the BHF logo is displayed") do
  raise unless TestBrowser.home_page.on_page?
end

And /^I click log in\/register$/ do
  TestBrowser.home_page.login
end
