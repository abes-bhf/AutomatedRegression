@events
Feature: events
	In order to raise money for the BHF
	As a BHF supporter
	I want to register for an event

	@event @transaction @paypal
	Scenario: event
		Given I navigate to the L2B registration form without logging in
		And I register for L2B with a new email and password
		And I fill in L2B event specific questions
		Then I decide to pay for registration through PayPal
		And I enter valid PayPal details
		Then I am taken to the event confirmation page

	@event @transaction @worldpay
	Scenario: event
		Given I navigate to the L2B registration form without logging in
		And I register for L2B with a new email and password
		And I fill in L2B event specific questions
		Then I decide to pay for registration through WorldPay
		And I enter valid WorldPay details
		Then I am taken to the event confirmation page

	@event
	Scenario: Live event test
		Given I am on the login registration page
		And I click register
		Then I am taken to the registration form
		Given I fill in the registration form
		Then I am taken to the account creation confirmation screen
		And I log out
		Given I navigate to the L2B registration form without logging in
		And I enter the email used in registration
		And I click login when prompted
		Then I can log in
		And I am taken to a pre-populated registration form that can be submitted once complete
		And I fill in event specific questions
		Then I decide to pay for registration through PayPal
		And I return to the event payment page
		Then I am taken to the events payment page
