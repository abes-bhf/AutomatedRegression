@volunteering
Feature: volunteering
	In order to support the BHF website
	As a BHF supporter
	I want to sign up to volunteer

# complete
	 @smoketest
	Scenario: Navigating to volunteering form
		Given I navigate to the Homepage
		And I scroll down to the volunteer with us section
		And I click a button to navigate to the volunteer page
		When I can click sign up
		Then I am taken to the volunteer sign in form

# complete
 @u17
		Scenario: Sign up to volunteer as u17 year old
			Given I navigate to the volunteer form
			And I start the volunteer form
			When I enter my age as u17
			Then I can sign up to volunteer in shops

# complete
 @over18 @shop
		Scenario: Sign up to volunteer at shops
			Given I navigate to the volunteer form
			And I start the volunteer form
			When I enter my age as over eighteen
			And I choose to volunteer in shops
			Then I can complete the form

# # currently out of action
# 	@over18 @events
# 		Scenario: Sign up to volunteer at events
# 			Given I navigate to the volunteer form
# 			And I start the volunteer form
# 			When I enter my age as over eighteen
# 			And I choose to volunteer at events
# 			Then I can complete the form

# # currently out of action
# 	@over18 @shopandevents
# 		Scenario: Sign up to volunteer in shops and events
# 			Given I navigate to the volunteer form
# 			And I start the volunteer form
# 			When I enter my age as over eighteen
# 			And I choose to volunteer in shops and events
# 			Then I can complete the form


	@over18 @raisingawareness
		Scenario: Sign up to raise awareness
			Given I navigate to the volunteer form
			And I start the volunteer form
			When I enter my age as over eighteen
			And I choose to raise awareness
			Then I can complete the form

	@over18 @shopandawareness
		Scenario: Sign up to volunteer in shops and raise awareness
			Given I navigate to the volunteer form
			And I start the volunteer form
			When I enter my age as over eighteen
			And I choose to volunteer in shops and raise awareness
			Then I can complete the form
