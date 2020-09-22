Given /^I navigate to the house clearance landing page$/ do
  TestBrowser.house_clearance_landing_page.visit
end

Given /^I submit a valid postcode$/ do
  TestBrowser.house_clearance_landing_page.submit_postcode
end

Then /^I am able to complete the house clearance form$/ do
  TestBrowser.house_clearance_v2_form.submit_form
end
