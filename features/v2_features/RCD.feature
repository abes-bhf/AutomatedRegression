@rcd
Feature: retail cash donation
	In order to support the BHF
	As a BHF supporter
	I want to donate cash to retails stores

# not required until launch page is made
	#  @smoketest
	# Scenario: Launching the enquiries form from the corporate volunteering page
	# 	Given I am on the corporate volunteer enquiries page
	# 	When I click enquire now
	# 	Then I am taken to the corporate volunteer form



# complete
 @submission
		Scenario: Complete rcd form
			Given I navigate to the rcd form
			And I complete the rcd form
			Then I am taken to the rcd thank you page

	@liveregression @transactionless
 		Scenario: Fill RCD up to point of completion
 			Given I navigate to the rcd form
 			And I complete the rcd form up to the final page
