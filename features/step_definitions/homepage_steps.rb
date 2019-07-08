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
  raise unless TestBrowser.f_and_e_form.on_page?
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
  random_main_link = TestBrowser.home_page.random_level_one
  random_main_link.hover
  @@hovered1 = random_main_link.text
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
  @@expectingurl = random_levelthree_link.a.href
  random_levelthree_link.click
end

Then /^I am taken to the correct page$/ do
  raise unless TestBrowser.browser.url == @@expectingurl
end

And /^I click on search$/ do
  TestBrowser.home_page.search_button.click
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
  raise unless TestBrowser.search_results_page.results.present?
end

Then /^I should not be shown any search results$/ do
  TestBrowser.search_results_page.on_page?
  raise if TestBrowser.search_results_page.results.present?
end
