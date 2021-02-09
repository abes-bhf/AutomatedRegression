Given /^I navigate to the newsletter signup page$/ do
  TestBrowser.newsletter_page.visit
end

Then /^The Newsletter signup page is displayed$/ do
  raise("Unable to find header for contact us page") unless TestBrowser.newsletter_page.on_page?
end

And /^I sign up for the newsletter$/ do
  TestBrowser.newsletter_page.fill_form
  TestBrowser.newsletter_page.continue
end

Then /^I receive newsletter signup confirmation$/ do
  raise("Did not receive confirmation for newsletter signup") unless TestBrowser.newsletter_page.confirmed?
  TestBrowser.newsletter_page.newsletter_output_email
end

Given('I complete the newsletter signup to the point of submission') do
  TestBrowser.newsletter_page.fill_form
end
