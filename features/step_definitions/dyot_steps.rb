Given /^I navigate to the DYOT page$/ do
  TestBrowser.dyot_page.visit
end

Given /^I navigate to the DYOT form$/ do
  TestBrowser.dyot_form.visit
end

Then /^The DYOT page is displayed$/ do
  raise("Unable to find header for DYOT page") unless TestBrowser.dyot_page.on_page?
end

And /^I fill in DYOT details$/ do
  TestBrowser.dyot_form.fill_form
end

Then /^I am taken to the DYOT confirmation page$/ do
  raise("Did not reach confirmation page for DYOT") unless TestBrowser.dyot_confirmation_page.on_page?
end
