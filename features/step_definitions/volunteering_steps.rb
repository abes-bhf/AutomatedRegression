

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

Given ("I navigate to the volunteer form") do
  TestBrowser.volunteering_form.visit
end


Given("I start the volunteer form") do
  TestBrowser.volunteering_form.continue
end

When("I enter my age as u17") do
  TestBrowser.volunteering_form.enter_u17
end

Then("I can sign up to volunteer in shops") do
  TestBrowser.volunteering_form.complete_form_u17
end

When("I enter my age as over eighteen") do
  TestBrowser.volunteering_form.enter_over18
end

When("I choose to volunteer in shops") do
  TestBrowser.volunteering_form.select_shop
end

Then("I can complete the form") do
  TestBrowser.volunteering_form.complete_form
end

When("I choose to volunteer at events") do
  TestBrowser.volunteering_form.select_event
end

When("I choose to volunteer in shops and events") do
  TestBrowser.volunteering_form.select_shop_and_event
end

When("I choose to raise awareness") do
  TestBrowser.volunteering_form.select_raise
end

When("I choose to volunteer in shops and raise awareness") do
  TestBrowser.volunteering_form.select_shop_and_awareness
end
