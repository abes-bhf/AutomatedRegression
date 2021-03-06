@donate
Feature: Donation
	In order to support the BHF website
	As a BHF supporter
	I want to make a donation

#@liveregression
	@oneoff @uatregression @validation @blank
	Scenario: Testing blank validation messages on one-off form
		Given I navigate to the Donation page
		And I select a one-off donation preset
		And I am taken to the first page of the donation form
		And I press continue without filling details
		Then the donate form should refresh with blank validation messages

#@liveregression
	@monthly  @uatregression @validation @blank
	Scenario: Testing blank validation messages on monthly form
		Given I navigate to the Donation page
		And I select a monthly donation preset
		And I am taken to the first page of the donation form
		And I press continue without filling details
		Then the donate form should refresh with blank validation messages
		And I fill in direct debit details
		Then I am taken to the monthly payment page
		And I press continue without filling direct debit details
		Then the direct debit form should refresh with blank validation messages

#@liveregression
	@oneoff @uatregression @validation @invalid
	Scenario: Testing validation messages for invalid data on one-off form
		Given I navigate to the Donation page
		And I select a one-off donation preset
		And I am taken to the first page of the donation form
		And I press continue after filling in invalid details
		Then The donate form should refresh with validation messages

#@liveregression
	@monthly  @uatregression @validation @invalid
	Scenario: Testing validation messages for invalid data on monthly form
		Given I navigate to the Donation page
		And I select a monthly donation preset
		And I am taken to the first page of the donation form
		And I press continue after filling in invalid details
		Then The donate form should refresh with validation messages
		And I fill in direct debit details
		Then I am taken to the monthly payment page
		And I press continue after filling in invalid direct debit details
		Then The direct debit form should refresh with validation messages


	@oneoff @liveregression @uatregression @pca
	Scenario: Testing address lookup on one-off form
		Given I navigate to the Donation page
		And I select a one-off donation preset
		And I am taken to the first page of the donation form
		Given I enter a valid postcode into the postcode lookup field
		And I search for the postcode
		And I select the first address from the list of matching addresses
		Then Address fields are shown with the address filled in


	@monthly @liveregression @uatregression @pca
	Scenario: Testing address lookup on monthly form
		Given I navigate to the Donation page
		And I select a monthly donation preset
		And I am taken to the first page of the donation form
		Given I enter a valid postcode into the postcode lookup field
		And I search for the postcode
		And I select the first address from the list of matching addresses
		Then Address fields are shown with the address filled in

	@oneoff @uatregression @submission @worldpay
	Scenario: Testing single donations complete with transactions (WorldPay)
		Given I navigate to the Donation page
		And I select a one-off donation preset
		And I am taken to the first page of the donation form
		When I fill in single payment details
		And I am taken to the one-off payment page
		And I answer no to the GiftAid question
		And I select Donate by credit/debit card
		And I am taken to the Worldpay page
		And I enter valid card details
		Then I am taken to the donation confirmation page

	@oneoff @uatregression @submission @paypal
	Scenario: Testing single donations complete with transactions (PayPal)
		Given I navigate to the Donation page
		And I select a one-off donation preset
		And I fill in single payment details
		Then I am taken to the one-off payment page
		And I answer no to the GiftAid question
		When I select Donate by PayPal
		And I enter valid PayPal details
		Then I am taken to the donation confirmation page

	@monthly @uatregression @submission
	Scenario: Testing monthly donations complete with transactions
		Given I navigate to the Donation page
		And I select a monthly donation preset
		And I fill in direct debit details
		Then I am taken to the monthly payment page
		When I enter valid direct debit details
		Then I am taken to the donation confirmation page























	@smoketest @oneoff
	Scenario: Visit donation page
		Given I navigate to the Donation page
		Then the Donation page is displayed
		And I select a one-off donation preset
		Then I am taken to the first page of the donation form

	@oneoff @worldpay @payment
	Scenario: Single preset donation card payment Worldpay
		Given I navigate to the Donation page
		And I select a one-off donation preset
		And I fill in single payment details
		Then I am taken to the one-off payment page
		And I answer no to the GiftAid question
		And I select Donate by credit/debit card
		Then I am taken to the Worldpay page
		When I enter valid card details
		Then I am taken to the donation confirmation page

	@monthly @payment
	Scenario: Monthly preset donation
		Given I navigate to the Donation page
		And I select a monthly donation preset
		And I fill in direct debit details
		Then I am taken to the monthly payment page
		And I should be able to select a start date within the next six months
		When I enter valid direct debit details
		Then I am taken to the donation confirmation page

	@oneoff @campaign @payment @worldpay
	Scenario: Single preset campaign donation card payment
		Given I navigate to a campaign page
		And I select a one-off campaign donation preset
		And I fill in single payment details
		Then I am taken to the one-off payment page
		And I answer no to the GiftAid question
		When I select Donate by credit/debit card
		And I enter valid card details
		Then I am taken to the donation confirmation page

	@monthly @campaign @payment
	Scenario: Monthly preset campaign donation card payment
		Given I navigate to a campaign page
		And I select a monthly campaign donation preset
		And I fill in direct debit details
		Then I am taken to the monthly payment page
		And I enter valid direct debit details
		Then I am taken to the donation confirmation page

	@oneoff @fail
	Scenario: Donation form validation
		Given I navigate to the Donation page
		And I select a one-off donation preset
		And I press continue without filling details
		Then the donate form should refresh with validation messages

	@oneoff @fail
	Scenario: Monthly donation payment page validation
		Given I navigate to the Donation page
		And I select a monthly donation preset
		And I fill in direct debit details
		And I am taken to the monthly payment page
		And I press continue without filling direct debit details
		Then the direct debit form should refresh with validation messages




	@oneoff @emailregression
	Scenario: Testing single donations complete with transactions
		Given I navigate to the Donation page
		And I select a one-off donation preset
		And I am taken to the first page of the donation form
		And I press continue without filling details
		Then the donate form should refresh with blank validation messages
		When I fill in single payment details
		And I am taken to the one-off payment page
		And I answer no to the GiftAid question
		And I select Donate by credit/debit card
		And I am taken to the Worldpay page
		And I enter valid card details
		Then I am taken to the donation confirmation page
		And I visit the Mailsac inbox for my donation email
		Then There should be an email confirmation of my one-off donation with expected content


	@transactionless @oneoff @liveregression
	Scenario: Testing single donations live without completing transactions
		Given I navigate to the Donation page
		And I select a one-off donation preset
		And I am taken to the first page of the donation form
		And I fill in single payment details
		And I am taken to the one-off payment page
		And I answer no to the GiftAid question
		And I select Donate by credit/debit card
		Then I am taken to the Worldpay page
		When I return to the payment page
		Then I am taken to the one-off payment page
		And I answer no to the GiftAid question
		When I select Donate by PayPal
		And I return to the payment page
		Then I am taken to the one-off payment page
