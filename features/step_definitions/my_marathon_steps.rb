Given /^I navigate to the MyMarathon page$/ do
  TestBrowser.my_marathon_page.visit
end

Given /^I navigate to the MyMarathon form$/ do
  TestBrowser.my_marathon_form.visit
end

Then /^The MyMarathon page is displayed$/ do
  raise("Unable to find header for MyMarathon page") unless TestBrowser.my_marathon_page.on_page?
end

And /^I fill in MyMarathon details$/ do
  TestBrowser.my_marathon_form.fill_form
end

Then /^I am taken to the MyMarathon confirmation page$/ do
  raise("Did not reach confirmation page for my marathon") unless TestBrowser.my_marathon_confirmation.on_page?
  TestBrowser.my_marathon_form.mm_output_email
end
