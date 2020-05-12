Given /^I navigate to the JW form$/ do
  TestBrowser.just_walk_form.visit
end

Then /^The JW form is displayed$/ do
  raise("Unable to find header for just walk page") unless TestBrowser.just_walk_form.on_page?
end

And /^I fill in JW details$/ do
  TestBrowser.just_walk_form.fill_form
end

Then /^I am taken to the JW confirmation page$/ do
  raise("Did not reach confirmation page for just walk") unless TestBrowser.just_walk_confirmation.on_page?
end
