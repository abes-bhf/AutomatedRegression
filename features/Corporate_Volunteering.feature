@corporatevolunteering
Feature: volunteering
	In order to support the BHF website
	As a BHF supporter
	I want to sign up to volunteer

# to do
	 @smoketest @corp_enquiries
	Scenario: Launching the enquiries form from the corporate volunteering page
		Given I am on the corporate volunteer enquiries page
		When I click enquire now
		Then I am taken to the corporate volunteer form

	# to do
		 @smoketest @corp_individual
		Scenario: Launching the enquiries form from the corporate volunteering page



# to do
 @corp_enquiries @wip
		Scenario: Sign up to enquire about corporate volunteering
			Given I navigate to the corporate volunteer form
			And I complete the corporate volunteer form
			Then I am taken to the enquiry confirmation page

# to do
 @corp_individual
 		Scenario: Sign up as an individual for corporate volunteering
			Given I navigate to the individual sign up form
			And I complete the corporate volunteer individual sign up form
			Then I am taken to the individual sign up confirmation page
