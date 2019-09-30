Given /^I navigate to the F and E form$/ do
  TestBrowser.f_and_e_form.visit
end

Then /^The F and E form is displayed$/ do
  raise unless TestBrowser.f_and_e_form.on_page?
end

Given /^I navigate to the House Clearance form$/ do
  TestBrowser.h_c_form.visit
end

Then /^The House Clearance form is displayed$/ do
  raise unless TestBrowser.h_c_form.on_page?
end

And /^The F and E how did you hear dropdown should be displayed with the expected options$/ do
  raise unless TestBrowser.f_and_e_form.dropdown_check('f_and_e_how_did_you_hear')
end

And /^The HC how did you hear dropdown should be displayed with the expected options$/ do
  raise unless TestBrowser.h_c_form.dropdown_check('hc_how_did_you_hear')
end

And /^The reason for requesting dropdown should be displayed with the expected options$/ do
  raise unless TestBrowser.h_c_form.dropdown_check('reason_for_requesting')
end

And /^I submit the F and E form without filling fields$/ do
  TestBrowser.f_and_e_form.continue
end

And /^I submit the HC form without filling fields$/ do
  TestBrowser.h_c_form.continue
end

Then /^The F and E form should refresh with validation messages$/ do
  raise unless TestBrowser.f_and_e_form.validation_present?('name', 'fande', 'telephone', 'dp')
end

Then /^The HC form should refresh with validation messages$/ do
  raise unless TestBrowser.h_c_form.validation_present?('name', 'hc', 'telephone', 'dp')
end

And /^I fill in house clearance details$/ do
  TestBrowser.h_c_form.fill_form
end

And /^I fill in furniture collection details$/ do
  TestBrowser.f_and_e_form.fill_form
end

Then /^I am taken to the F and E confirmation page with a collection reference$/ do
  raise unless TestBrowser.f_and_e_confirmation.on_page?
  @@f_and_e_reference = TestBrowser.browser.url.split('=')[1]
end

Then /^I am taken to the HC confirmation page with a collection reference$/ do
  raise unless TestBrowser.h_c_confirmation.on_page?
  @@h_c_reference = TestBrowser.browser.url.split('=')[1]
end

Given /^I navigate to flow$/ do
  TestBrowser.flow.visit
end

Then /^The flow login page is displayed$/ do
  raise unless TestBrowser.flow.on_page?
end

And /^I log into flow$/ do
  TestBrowser.flow.visit
  TestBrowser.flow.login
end

Then /^I am logged into flow$/ do
  raise unless TestBrowser.flow.logged_in?
end

And /^I view requests for all shops$/ do
  TestBrowser.flow.all_shops
end

And /^I search for a collection reference$/ do
  # @@f_and_e_reference = 'W41-A24048689'
  TestBrowser.flow.searchref(@@f_and_e_reference)
end

Then /^the request will be displayed$/ do
  raise unless TestBrowser.flow.searchresult(@@f_and_e_reference) != nil
end

Given /^I view more details about the request$/ do
  TestBrowser.flow.viewresult(@@f_and_e_reference)
end

Then /^I should see more info about the request$/ do
  TestBrowser.flow.details(@@f_and_e_reference)
end

And /^I can either accept or decline the request$/ do
  pending
end
