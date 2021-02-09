@loginregister
Feature: Login/Registration
	In order to save my details to the BHF website
	As a BHF supporter
	I want to register and log in

	@smoke @uatregression
	Scenario: Navigating to user account registration form
		Given I am on the login registration page
		And I click register
		Then I am taken to the registration form

	@transactionless @liveregression @uatregression @validation
	Scenario: Testing blank validation messages on login page
		Given I am on the login registration page
		And I click login without filling in details
		Then The login page should refresh with blank validation messages

	@transactionless @liveregression @uatregression @validation
	Scenario: Testing validation message for invalid email on login page
		Given I am on the login registration page
		And I click login with an invalid email
		Then The login page should refresh with an email validation message

	@transactionless @liveregression @uatregression @validation
	Scenario: Testing validation messages for invalid password on login page
		Given I am on the login registration page
		And I click login with an invalid password
		Then The login page should refresh with a password validation message

	@transactionless @liveregression @uatregression @validation
	Scenario: Testing blank validation messages on registration form
		Given I am on the login registration page
		And I click register
		And I am taken to the registration form
		And I press continue without filling details
		Then The registration form should refresh with blank validation messages

	@transactionless @liveregression @uatregression @validation @invalid
	Scenario: Testing validation messages for invalid data on registration form
		Given I am on the login registration page
		And I click register
		And I am taken to the registration form
		And I register with invalid details
		Then The registration form should refresh with validation messages

	@submission @uatregression
	Scenario: User account registration
		Given I am on the login registration page
		And I click register
		Then I am taken to the registration form
		Given I fill in the registration form
		Then I am taken to the account creation confirmation screen
		And I am logged in
		Given I log out
		Then I can log in with the details used in registration
		Then I am on my account page

	Scenario: Events form account recognition
		Given I log out
		And I navigate to the L2B registration form without logging in
		And I enter the email used in registration
		Then I am prompted to log in to the account associated with the email
		And I fill in in the registration form with valid details
		Then I am taken to the event specific questions page
		Given I navigate to the L2B registration form without logging in
		And I enter the email used in registration
		And I click login when prompted
		Then I can log in
		And I am taken to a pre-populated registration form that can be submitted once complete
		And I fill in event specific questions
		And I decide to pay for registration through PayPal
		And I enter valid PayPal details
		Then I am taken to the event confirmation page

	#@transactionless @liveregression
	Scenario: User account registration
		Given I am on the login registration page
		And I click register
		Then I am taken to the registration form
		Given I fill in the registration form
		Then I am taken to the account creation confirmation screen
		And I am logged in
		And I log out
		Then I can log in with the details used in registration
		Then I am on my account page
		Given I log out
		And I navigate to the L2B registration form without logging in
		And I enter the email used in registration
		Then I am prompted to log in to the account associated with the email
		And I fill in in the registration form with valid details
		Then I am taken to the event specific questions page
		Given I navigate to the L2B registration form without logging in
		And I enter the email used in registration
		And I click login when prompted
		Then I can log in
		And I am taken to a pre-populated registration form that can be submitted once complete
		And I fill in event specific questions
		Then I am taken to the events payment page
		Then I decide to pay for registration through PayPal
		And I return to the event payment page
		Then I am taken to the events payment page

 		@liveregression @uatregression @pca
		Scenario: Testing address lookup on one-off form
			Given I am on the login registration page
			And I click register
			And I am taken to the registration form
			And I enter and select a valid postcode from the lookup
			Then the correct addresses appear in the right fields

		@transactionless @liveregression
		Scenario: User account registration liveregression
			Given I am on the login registration page
			And I click register
			Then I am taken to the registration form
			Given I fill in the registration form
			Then I am taken to the account creation confirmation screen
			And I am logged in
			And I log out
			Then I can log in with the details used in registration
			Then I am on my account page
			Given I log out
