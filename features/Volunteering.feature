@volunteering
Feature: volunteering
	In order to support the BHF website
	As a BHF supporter
	I want to sign up to volunteer

# in progress
	 @smoketest
	Scenario: Navigating to volunteering form
		Given I navigate to the Homepage
		And I scroll down to the volunteer with us section
		And I click a button to navigate to the volunteer page
		When I can click sign up
		Then I am taken to the volunteer sign in form




  	@transactionless @liveregression @uatregression @validation @orderforme @firingblanks @guest
	Scenario: Testing blank validation messages on publications form sign in page
		Given I navigate to the publications page
		And I select a booklet
		And I click add to basket
		And I am taken to my basket
		And I navigate to the basket form
		Then I fill in the form triggering blank validation messages on each page



  	@transactionless @liveregression @uatregression @validation @orderforme @invalid @guest
	Scenario: Testing validation messages on invalid data on publications form
		Given I navigate to the publications page
		And I select a booklet
		And I click add to basket
		And I am taken to my basket
		And I navigate to the basket form
		Then I fill in the form triggering invalid validation messages on each page


		@transactionless @liveregression @uatregression @validation @orderforme @signedin
	Scenario: Testing validation messages on the signed in journey
		Given I navigate to the publications page
		And I select a booklet
		And I click add to basket
		And I am taken to my basket
		And I navigate to the basket form
		Then I trigger the correct validation messages on the signedin journey


		@postcode
	Scenario: Testing address lookup on publications form
		Given I navigate to the publications form your-address page
		And I enter a valid postcode into the postcode lookup
		And I click the Find Address button
		And I select an address from the list of matching addresses
		Then address fields are shown with the address filled in


		@export @guest @worldpay
	Scenario: Testing worldpay works when a donation is added to basket as a guest
		Given I navigate to the publications page
		And I select a booklet
		And I click add to basket
		And I am taken to my basket
		And I add a preset donation to the basket
		And I see the donation in the basket
		And I navigate to the basket form
		And I fill in the publications form
		And I press pay via worldpay
		Then I am taken to the Worldpay page
		And I enter valid card details
		Then I am taken to the order confirmation page


#in progress
		@export @happypath @guest
	Scenario: Testing publications happy path as guest
		Given I navigate to the start of the volunteering form
		And I fill in the form
		And I click add to basket
		And I am taken to my basket
		And I navigate to the basket form
		And I fill in the publications form
		And I press continue
		Then I am taken to the order confirmation page

		@export @signedin @worldpay
	Scenario: Testing worldpay works with a donation in the basket
		Given I navigate to the publications page
		And I select a booklet
		And I click add to basket
		And I am taken to my basket
		And I add a preset donation to the basket
		And I see the donation in the basket
		And I navigate to the basket form
		And I sign in to the publications form
		And I fill in the rest of the publications form
		And I press pay via worldpay
		Then I am taken to the Worldpay page
		And I enter valid card details
		Then I am taken to the order confirmation page


		@export @happypath @signedin
	Scenario: Testing publications happy path when signed in
		Given I navigate to the publications page
		And I select a booklet
		And I click add to basket
		And I am taken to my basket
		And I navigate to the basket form
		And I sign in to the publications form
		And I fill in the rest of the publications form
		Then I am taken to the order confirmation page


		@export @alt_billing @worldpay @fol
	Scenario: Testing different billing address to delivery address1
		Given I navigate to the publications page
		And I select a booklet
		And I click add to basket
		And I am taken to my basket
		And I add a preset donation to the basket
		And I see the donation in the basket
		And I navigate to the basket form
		And I fill in the publications form with a different billing address
		And I press pay via worldpay
		Then I am taken to the Worldpay page
		And I enter valid card details
		Then I am taken to the order confirmation page


		@export @company_order @fol
	Scenario: Testing order as a company journey
		Given I navigate to the publications page
		And I select a booklet
		And I click add to basket
		And I am taken to my basket
		And I navigate to the basket form
		And I fill in the publications form ordering as a company
		And I press continue
		Then I am taken to the order confirmation page


		@export @friend_order
	Scenario: Testing order for a friend journey
		Given I navigate to the publications page
		And I select a booklet
		And I click add to basket
		And I am taken to my basket
		And I navigate to the basket form
		And I fill in the publications form ordering for a friend
		And I press continue
		Then I am taken to the order confirmation page


		@export @multipub @guest
	Scenario: Testing multiple publications in basket
		Given I navigate to the publications page
		And I select a booklet
		And I click add to basket
		And I am taken to my basket
		And I increase the number of publications in my basket
		And I navigate to the basket form
		And I fill in the publications form
		And I press continue
		Then I am taken to the order confirmation page




		# no Spinners on publication form
		# unsure what emails
