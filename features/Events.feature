@events
Feature: events
	In order to raise money for the BHF
	As a BHF supporter
	I want to register for an event

	Scenario: User navigates to the login/registration page
		Given I navigate to the events page
		And I select bike rides

	@event
	Scenario: event
		Given I am on the login registration page
		And I click register
		Then I am taken to the registration form
		Given I fill in the registration form
		Then I am taken to the account creation confirmation screen
		And I am logged in
		Given I navigate to the L2B registration form without logging in
		And I enter the email used in registration
		And I click login when prompted
		Then I can log in
		And I am taken to a pre-populated registration form that can be submitted once complete
		And I fill in event specific questions
