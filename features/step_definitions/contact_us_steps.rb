Given /^I navigate to the contact us page$/ do
  TestBrowser.contact_us_page.visit
end

Then /^I am taken to the contact us form$/ do
  raise("Unable to find header for contact us page") unless TestBrowser.contact_us_page.on_page?
end

And /^I fill in the contact us form$/ do
  TestBrowser.contact_us_page.fill_form
end

Then /^I am taken to contact us confirmation page$/ do
  pending
end
