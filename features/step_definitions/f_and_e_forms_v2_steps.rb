Given /^I navigate to the F and E form v2$/ do
  TestBrowser.f_and_e_forms_v2.visit
end

Given /^I fill in the F and E form v2$/ do
  TestBrowser.f_and_e_forms_v2.fill_form
end

Then /^I am taken to the F and E form v2 confirmation page$/ do
  TestBrowser.f_and_e_forms_v2.continue
  TestBrowser.f_and_e_forms_v2.journey_fin
end
