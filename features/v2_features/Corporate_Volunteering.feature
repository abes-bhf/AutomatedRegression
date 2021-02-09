@corporatevolunteering
Feature: volunteering
	In order to support the BHF website
	As a BHF supporter
	I want to sign up to volunteer

# complete
	#  @smoketest @corp_enquiries
	# Scenario: Launching the enquiries form from the corporate volunteering page
	# 	Given I am on the corporate volunteer enquiries page
	# 	When I click enquire now
	# 	Then I am taken to the corporate volunteer form



# complete
 @corp_enquiries @submission
		Scenario: Sign up to enquire about corporate volunteering
			Given I navigate to the corporate volunteer form
			And I complete the corporate volunteer form
			Then I am taken to the enquiry confirmation page

# complete
 @corp_individual @submission
 		Scenario: Sign up as an individual for corporate volunteering
			Given I navigate to the individual sign up form
			And I complete the corporate volunteer individual sign up form
			Then I am taken to the individual sign up confirmation page

	# complete
	 @corp_individual @transactionless @liveregression
	 		Scenario: Progress without submitting through form for an individual for corporate volunteering
				Given I navigate to the individual sign up form
				Then I complete the corporate volunteer individual sign up form up to the point of submission

	# complete
	 @corp_enquiries @transactionless @liveregression
			Scenario: Sign up to enquire about corporate volunteering
				Given I navigate to the corporate volunteer form
				Then I complete the corporate volunteer up to the point of submission
