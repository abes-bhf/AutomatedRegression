Given("I navigate to the Homepage") do
  TestBrowser.home_page.visit
end

Then("the BHF logo is displayed") do
  raise unless TestBrowser.home_page.on_page?
end

And /^I click log in\/register$/ do
  TestBrowser.home_page.login
end

And /^I click Book a collection$/ do
  TestBrowser.home_page.book_a_collection
end

Then /^I am taken to the f and e form$/ do
  raise unless TestBrowser.f_and_e_forms_v2.on_page?
end

And /^I click Donate$/ do
  TestBrowser.home_page.donate
end

Then /^I am taken to the donation page$/ do
  raise unless TestBrowser.donation_page.on_page?
end

And /^I click one of the four main links$/ do
  random_main_link = TestBrowser.home_page.random_level_one
  random_main_link.click!
  @@expectingurl = random_main_link.href
end

And /^I hover over one of the four main links$/ do
  @@random_main_link = TestBrowser.home_page.random_level_one
  @@hovered1 = @@random_main_link.text
  sleep 2
  @@random_main_link.hover
end

And /^I hover over a level two link with subitems$/ do
  random_leveltwo_link = TestBrowser.home_page.random_level_two_with_subitems
  random_leveltwo_link.hover
  @@hovered2 = random_leveltwo_link.as[0].text
end

And /^I click one of the level two links$/ do
  random_leveltwo_link = TestBrowser.home_page.random_level_two
  @@expectingurl = random_leveltwo_link.as[0].href
  random_leveltwo_link.click
end

And /^I click one of the level three links$/ do
  random_levelthree_link = TestBrowser.home_page.random_level_three
  begin
    @@expectingurl = random_levelthree_link.a.href
    random_levelthree_link.click
  rescue NoMethodError
    raise("unable to find link, pls try again")
    # binding.pry
  end
end

Then /^I am taken to the correct page$/ do
  if @@expectingurl == EnvConfig.base_url+"shop/find-your-local-shop"
    @@expectingurl = EnvConfig.base_url+"search/location-search"
  end
  # raise("Expected to be on #{@@expectingurl}, am currently on #{TestBrowser.browser.url}") unless TestBrowser.browser.url == @@expectingurl
  # binding.pry unless TestBrowser.browser.url == @@expectingurl
end

And /^I click on search$/ do
  TestBrowser.home_page.search_button.click!
end

Then /^The search bar should open$/ do
  raise unless TestBrowser.home_page.search_bar.present?
end

And /^I enter a valid search term$/ do
  TestBrowser.home_page.search('hearts')
end

And /^I enter an invalid search term$/ do
  TestBrowser.home_page.search('hjvdhfvbjdhfvbjdhfbvjdhfvb')
end

Then /^I should be taken to the search results for that term$/ do
  TestBrowser.search_results_page.on_page?
  raise unless TestBrowser.search_results_page.results.size > 0
end

Then /^I should not be shown any search results$/ do
  TestBrowser.search_results_page.on_page?
  raise if TestBrowser.search_results_page.results.size > 0
end

Given("I search for nothing") do
  TestBrowser.home_page.blank_search
end

Given("I land on the search results page") do
  TestBrowser.home_page.search_landing
end

Given("I switch to the Shops and services tab") do
  TestBrowser.home_page.change_tab
end

Given("I enter a valid postcode") do
  TestBrowser.home_page.submit_postcode
end

Then("I see relevant results") do
  TestBrowser.home_page.verify_result
end
