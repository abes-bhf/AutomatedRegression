Given /^I navigate to the events page$/ do
  TestBrowser.events_page.visit
  raise unless TestBrowser.events_page.on_page?
end

And /^I select bike rides$/ do
  TestBrowser.events_page.select_category('bike rides')
end

And /^I register for L2B with a new email and password$/ do
  TestBrowser.london_to_brighton_registration1.new_registration
end
