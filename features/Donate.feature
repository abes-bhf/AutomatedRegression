@donate
Feature: Homepage
	In order to support the BHF website
	As a BHF supporter
	I want to make a donation

	@smoketest @oneoff @geg
	Scenario: Visit donation page
		Given I navigate to the Donation page
		Then the Donation page is displayed
		And I select a donation preset
		Then I am taken to the first page of the one-off donation form

	@oneoff @worldpay @payment
	Scenario: Single preset donation card payment Worldpay
		Given I navigate to the Donation page
		And I select a donation preset
		And I fill in single payment details
		Then I am taken to the one-off payment page
		And I answer no to the GiftAid question
		And I select Donate by credit/debit card
		Then I am taken to the Worldpay page
		When I enter valid card details
		Then I am taken to the confirmation page

	@oneoff @paypal @payment
	Scenario: Single preset donation card payment PayPal
		Given I navigate to the Donation page
		And I select a donation preset
		And I fill in single payment details
		Then I am taken to the one-off payment page
		Given I answer no to the GiftAid question
		And I answer no to the GiftAid question
		When I select Donate by PayPal
		And I enter valid PayPal details
		Then I am taken to the confirmation page

	@monthly @payment
	Scenario: Monthly preset donation
		Given I navigate to the Donation page
		And I select a monthly donation preset
		And I fill in direct debit details
		Then I am taken to the monthly payment page
		And I should be able to select a start date within the next six months
		When I enter valid direct debit details
		Then I am taken to the confirmation page

	@oneoff @campaign @payment @worldpay
	Scenario: Single preset campaign donation card payment
		Given I navigate to a campaign page
		And I select a one-off campaign donation preset
		And I fill in single payment details
		Then I am taken to the one-off payment page
		And I answer no to the GiftAid question
		When I select Donate by credit/debit card
		And I enter valid card details
		Then I am taken to the confirmation page

	@monthly @campaign @payment
	Scenario: Monthly preset campaign donation card payment
		Given I navigate to a campaign page
		And I select a monthly campaign donation preset
		And I fill in direct debit details
		Then I am taken to the monthly payment page
		And I enter valid direct debit details
		Then I am taken to the confirmation page

	@oneoff @fail
	Scenario: Donation form validation
		Given I navigate to the Donation page
		And I select a donation preset
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


	@oneoff @uatregression
	Scenario: Testing single donations complete with transactions
		Given I navigate to the Donation page
		And I select a donation preset
		And I am taken to the first page of the one-off donation form
		And I press continue without filling details
		Then the donate form should refresh with validation messages
		When I fill in single payment details
		And I am taken to the one-off payment page
		And I answer no to the GiftAid question
		And I select Donate by credit/debit card
		And I am taken to the Worldpay page
		And I enter valid card details
		Then I am taken to the confirmation page

	@oneoff @emailregression
	Scenario: Testing single donations complete with transactions
		Given I navigate to the Donation page
		And I select a donation preset
		And I am taken to the first page of the one-off donation form
		And I press continue without filling details
		Then the donate form should refresh with validation messages
		When I fill in single payment details
		And I am taken to the one-off payment page
		And I answer no to the GiftAid question
		And I select Donate by credit/debit card
		And I am taken to the Worldpay page
		And I enter valid card details
		Then I am taken to the confirmation page
		And I visit the Mailsac inbox for my donation email
		Then There should be an email confirmation of my one-off donation with expected content

	@monthly @uatregression
	Scenario: Testing monthly donations complete with transactions
		Given I navigate to the Donation page
		And I select a monthly donation preset
		And I fill in direct debit details
		Then I am taken to the monthly payment page
		And I press continue without filling direct debit details
		Then the direct debit form should refresh with validation messages
		When I enter valid direct debit details
		Then I am taken to the confirmation page


	@transactionless @oneoff @liveregression
	Scenario: Testing single donations live without completing transactions
		Given I navigate to the Donation page
		And I select a donation preset
		And I am taken to the first page of the one-off donation form
		And I press continue without filling details
		Then the donate form should refresh with validation messages
		When I fill in single payment details
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


	@transactionless @monthly @liveregression
	Scenario: Testing monthly donations live without completing transactions
		Given I navigate to the Donation page
		And I select a monthly donation preset
		And I fill in direct debit details
		Then I am taken to the monthly payment page
		And I press continue without filling direct debit details
		Then the direct debit form should refresh with validation messages
