Given /^I navigate to the research newsletter signup page$/ do
  TestBrowser.research_newsletter_page.visit
end

Then /^The research newsletter signup page is displayed$/ do
  raise("Unable to find research newsletter page") unless TestBrowser.research_newsletter_page.on_page?
end

And /^I sign up for the research newsletter$/ do
  TestBrowser.research_newsletter_page.fill_form
end

Then /^I receive research newsletter signup confirmation$/ do
  raise("Did not receive confirmation for newsletter signup") unless TestBrowser.research_newsletter_page.confirmed?
end
