Given /^I navigate to the events page$/ do
  TestBrowser.events_page.visit
  raise unless TestBrowser.events_page.on_page?
end

And /^I select bike rides$/ do
  TestBrowser.events_page.select_category('bike rides')
end
