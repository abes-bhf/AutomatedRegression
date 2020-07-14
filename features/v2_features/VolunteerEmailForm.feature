@volunteer_email
Feature: volunteer email
	In order to support the BHF website
	As a BHF supporter
	I want to sign up to receive volunteer news emails


	 @smoketest
	Scenario: Launching the volunteer emails form from the volunteering hub
		Given I am on the volunteer hub page
		When I click sign me up
		Then I am taken to the volunteer email form


 		@submission
		Scenario: Sign up to receive volunteer emails
			Given I navigate to the volunteer email form
			And I complete the volunteer email form
			Then I am taken to the volunteer email confirmation page
