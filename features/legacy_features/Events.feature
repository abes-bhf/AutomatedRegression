@events
Feature: events
	In order to raise money for the BHF
	As a BHF supporter
	I want to register for an event

	@event @paypal
	Scenario: event paypal checkout
		Given I navigate to the L2B registration form without logging in
		And I register for L2B with a new email and password
		And I fill in event specific questions
		Then I decide to pay for registration through PayPal
		And I enter valid PayPal details
		Then I am taken to the event confirmation page

	@event @worldpay
	Scenario: event worldpay checkout
		Given I navigate to the L2B registration form without logging in
		And I register for L2B with a new email and password
		And I fill in event specific questions
		Then I decide to pay for registration through WorldPay
		And I am taken to the Worldpay page
		And I enter valid card details
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

		@event @run @worldpay @submission
		Scenario: sign up to a run with worldpay
			Given I navigate to the kew gardens 10k run without logging in
			And I register for kew gardens with a new email and password
			And I fill in run event specific questions
			Then I decide to pay for registration through WorldPay
			And I am taken to the Worldpay page
			And I enter valid card details
			Then I am taken to the event confirmation page

		@event @run @paypal @submission
		Scenario: sign up to a run with worldpay
			Given I navigate to the kew gardens 10k run without logging in
			And I register for kew gardens with a new email and password
			And I fill in run event specific questions
			Then I decide to pay for registration through PayPal
			And I enter valid PayPal details
			Then I am taken to the event confirmation page

		@event @run @worldpay @liveregression @transactionless
		Scenario: sign up to a run with worldpay
			Given I navigate to the kew gardens 10k run without logging in
			And I register for kew gardens with a new email and password
			And I fill in run event specific questions
			Then I decide to pay for registration through WorldPay
			And I am taken to the Worldpay page

		@event @run @paypal @liveregression @transactionless
		Scenario: sign up to a run with worldpay
			Given I navigate to the kew gardens 10k run without logging in
			And I register for kew gardens with a new email and password
			And I fill in run event specific questions
			Then I decide to pay for registration through PayPal
