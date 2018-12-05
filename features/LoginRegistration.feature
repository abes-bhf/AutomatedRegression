@login @register
Feature: Login/Registration
	In order to save my details to the BHF website
	As a BHF supporter
	I want to register and log in

	@smoketest
	Scenario: User navigates to the login/registration page
		Given I navigate to the Homepage
		And I click log in/register
		Then I am taken to the login registration page

	@form
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
		And I decide to pay for registration through PayPal
		And I enter valid PayPal details
		Then I am taken to the event confirmation page

	@transactionless @liveregression
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
