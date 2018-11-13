@donate
Feature: Homepage
	In order to support the BHF website
	As a BHF supporter
	I want to make a donation

	Scenario: Visit donation page
		Given I navigate to the Donation page
		Then the Donation page is displayed

	@single @smoketest
	Scenario: Single preset donation
		Given I navigate to the Donation page
		And I select a donation preset
		Then I am taken to the first page of the one-off donation form

	@single @worldpay @payment
	Scenario: Single preset donation card payment Worldpay
		Given I navigate to the Donation page
		And I select a donation preset
		And I fill in single payment details
		Then I am taken to the one-off payment page
		When I select Donate by credit/debit card
		Then I am taken to the Worldpay page
		When I enter valid card details
		Then I am taken to the confirmation page

	@single @paypal @payment
	Scenario: Single preset donation card payment PayPal
		Given I navigate to the Donation page
		And I select a donation preset
		And I fill in single payment details
		Then I am taken to the one-off payment page
		When I select Donate by PayPal
		And I enter valid PayPal details
		Then I am taken to the confirmation page

	@monthly @payment
	Scenario: Monthly preset donation
		Given I navigate to the Donation page
		And I select a monthly donation preset
		And I fill in direct debit details
		Then I am taken to the monthly payment page
		And I enter valid direct debit details
		Then I am taken to the confirmation page

	@oneoff @campaign @payment @worldpay
	Scenario: Single preset campaign donation card payment
		Given I navigate to a campaign page
		And I select a one-off campaign donation preset
		And I fill in single payment details
		Then I am taken to the one-off payment page
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

	@monthly @fail
	Scenario: Monthly donation payment page validation
		Given I navigate to the Donation page
		And I select a monthly donation preset
		And I fill in direct debit details
		And I am taken to the monthly payment page
		And I press continue without filling direct debit details
		Then the direct debit form should refresh with validation messages


	@single @uatregression
	Scenario: Testing single donations complete with transactions
		Given I navigate to the Donation page
		And I select a donation preset
		And I am taken to the first page of the one-off donation form
		And I press continue without filling details
		Then the donate form should refresh with validation messages
		When I fill in single payment details
		And I am taken to the one-off payment page
		And I select Donate by credit/debit card
		And I am taken to the Worldpay page
		And I enter valid card details
		Then I am taken to the confirmation page

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


	@transactionless @single @liveregression
	Scenario: Testing single donations live without completing transactions
		Given I navigate to the Donation page
		And I select a donation preset
		And I am taken to the first page of the one-off donation form
		And I press continue without filling details
		Then the donate form should refresh with validation messages
		When I fill in single payment details
		And I am taken to the one-off payment page
		And I select Donate by credit/debit card
		Then I am taken to the Worldpay page
		When I return to the payment page
		Then I am taken to the one-off payment page
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
