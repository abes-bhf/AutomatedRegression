

Given("I scroll down to the volunteer with us section") do
  TestBrowser.volunteering_page.scroll_to_volunteering
end

Given("I click a button to navigate to the volunteer page") do
  TestBrowser.volunteering_page.volunteer_link_click
end

When("I can click sign up") do
  TestBrowser.volunteering_page.vol_sign_up
end

Then("I am taken to the volunteer sign in form") do
  TestBrowser.volunteering_form.on_page?
end
