@auto_training
Feature: Training for automation on v2 forms

	@training_v2
	Scenario: V2 form - Training for automation using Heart of Steel form
	  Given I navigate to the heart of steel page
	  And I select I am over sixteen
	  And I fill in engraving details
	  And I fill in your details
	  Then I fill in my address
	  Then I share my story
	  And fill in gdpr
	  Then I end up in order summary page
	  And add donation
	  Then add gift aid
	  And I press pay via worldpay
	  Then I am taken to the Worldpay page
	  And I enter valid card details
	  Then am presented with the hos confirmation page

#add your new scenario here
