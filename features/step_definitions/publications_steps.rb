Given("I navigate to the publications page") do
  TestBrowser.publications_page.visit
  # TestBrowser.publications_page.decookie
end

Given("I click the search button") do
    TestBrowser.publications_page.search_button.scroll.to :center
    sleep 1
    TestBrowser.publications_page.search_button.click
end

Then("I can see a list of publications") do
  TestBrowser.publications_page.search_results.scroll.to :center
  sleep 2
  raise if TestBrowser.publications_page.search_count < 2
end



Given("I select a booklet") do
  selection = TestBrowser.publications_page.select_publication
  selection.scroll.to :center
  sleep 1
  selection.click
end

Given("I click add to basket") do
  TestBrowser.publications_page.add_to_basket.click
end

Given("I am taken to my basket") do
  TestBrowser.publications_basket_page.on_page?
end

Given("I add a preset donation to the basket") do
  TestBrowser.publications_basket_page.add_preset_donation
end

Given("I see the donation in the basket") do
  TestBrowser.publications_basket_page.donation_present
end
# the below will need changing when the button works to navigate straight to the form
Given("I navigate to the basket form") do
  TestBrowser.publications_form.visit
  # TestBrowser.publications_form.on_page?
end

Given("I fill in the publications form") do
  TestBrowser.publications_form.fill_form
end



Then("I am taken to the order confirmation page") do
  TestBrowser.pub_confirmation_page.on_page?
end

Given("I press pay via worldpay") do
  TestBrowser.publications_form.select_worldpay
end

Given("I sign in to the publications form") do
  TestBrowser.publications_form.sign_in
end

Given("I fill in the rest of the publications form") do
  TestBrowser.publications_form.fill_the_rest
end

Given("I press continue") do
  TestBrowser.publications_form.continue
end

Then("I fill in the form triggering blank validation messages on each page") do
  TestBrowser.publications_form.firing_blanks
end

Then("I fill in the form triggering invalid validation messages on each page") do
  TestBrowser.publications_form.invalid_fill
end

# When /^I enter valid PayPal details$/ do
#   TestBrowser.pay_pal_page.login # Write code here that turns the phrase above into concrete actions
# end


Given("I fill in the publications form ordering as a company") do
  TestBrowser.publications_form.fill_company_form
end

Given("I fill in the publications form ordering for a friend") do
  TestBrowser.publications_form.fill_friend_form
end

Given("I fill in the publications form with a different billing address") do
  TestBrowser.publications_form.different_billing
end

Then("I trigger the correct validation messages on the signedin journey") do
  TestBrowser.publications_form.signedin_validation
end

Given("I navigate to the publications form your-address page") do
  TestBrowser.publications_form.go_to_address
end

Given("I enter a valid postcode into the postcode lookup") do
  TestBrowser.publications_form.fill_postcode
end

Given("I click the Find Address button") do
  TestBrowser.publications_form.find_address
end


Then("I select an address from the list of matching addresses") do
  TestBrowser.publications_form.select_address
end

Then("address fields are shown with the address filled in") do
  TestBrowser.publications_form.verify_address
end

Given("I increase the number of publications in my basket") do
  TestBrowser.publications_basket_page.add_more_pub
end

Given("I verify the summary matches the basket") do
  TestBrowser.publications_form.verify_summary # not working
end
