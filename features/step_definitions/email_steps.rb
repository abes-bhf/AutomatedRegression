Given /^I visit the Mailsac inbox for my email$/ do
  TestBrowser.mailsac_page.visit
  TestBrowser.mailsac_page.inbox("abes_pet_robot@mailsac.com")
end

Given /^I visit the Mailsac inbox for my donation email$/ do
  TestBrowser.mailsac_page.visit
  TestBrowser.mailsac_page.inbox(@@donate_email)
end

Then /^There should be an email confirmation of my collection request with expected content$/ do
  @@f_and_e_reference = "h64-B280619010844442"
  TestBrowser.mailsac_page.msg_by_subject("Your BHF van collection booking request reference: #{@@f_and_e_reference}")
  TestBrowser.mailsac_page.f_and_e_content_check
end

Then /^There should be an email confirmation of my one-off donation with expected content$/ do
  TestBrowser.mailsac_page.msg_by_subject("Thank you for your donation! You are a superstar.")
  TestBrowser.mailsac_page.one_off_donation_content_check
end
