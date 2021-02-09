Given /^I navigate to the research newsletter signup page$/ do
  TestBrowser.research_newsletter_page.visit
end

Then /^The research newsletter signup page is displayed$/ do
  raise("Unable to find research newsletter page") unless TestBrowser.research_newsletter_page.on_page?
end

And /^I sign up for the research newsletter$/ do
  TestBrowser.research_newsletter_page.fill_form
  TestBrowser.research_newsletter_page.continue
end

Then /^I receive research newsletter signup confirmation$/ do
  raise("Did not receive confirmation for newsletter signup") unless TestBrowser.research_newsletter_page.confirmed?
  TestBrowser.research_newsletter_page.research_newsletter_output
end

Given('I complete the research newsletter signup to the point of submission') do
  TestBrowser.research_newsletter_page.fill_form
end
