@auto_training
Feature: Automation training for a legacy form
	In order to support the BHF website
	As a BHF supporter
	I want to make a donation

	@smoketest @oneoff
	Scenario: Visit donation page
		Given I navigate to the Donation page
		Then the Donation page is displayed
		And I select a one-off donation preset
		Then I am taken to the first page of the donation form

	@oneoff @worldpay @payment
	Scenario: Single preset donation card payment Worldpay
		Given I navigate to the Donation page
		And I select a one-off donation preset
		And I fill in single payment details
		Then I am taken to the one-off payment page
		And I answer no to the GiftAid question
		And I select Donate by credit/debit card
		Then I am taken to the Worldpay page
		When I enter valid card details
		Then I am taken to the donation confirmation page
