@home @uatregression
Feature: Homepage
	In order to navigate the BHF website
	As a BHF supporter
	I want to visit the homepage

	Scenario: User navigates to the homepage
		Given I navigate to the Homepage
		Then the BHF logo is displayed

	Scenario: User navigates to the login/registration page
		Given I navigate to the Homepage
		And I click log in/register
		Then I am taken to the login registration page

	Scenario: User navigates to Furniture and Electrical collection form
		Given I navigate to the Homepage
		And I click Book a collection
		Then I am taken to the f and e form

	Scenario: User navigates to donation page
		Given I navigate to the Homepage
		And I click Donate
		Then I am taken to the donation page

	Scenario: Level one links
		Given I navigate to the Homepage
		And I click one of the four main links
		Then I am taken to the correct page

	Scenario: Level two links
		Given I navigate to the Homepage
		And I hover over one of the four main links
		And I click one of the level two links
		Then I am taken to the correct page

	@yy
	Scenario: Level three links
		Given I navigate to the Homepage
		And I hover over one of the four main links
		And I hover over a level two link with subitems
		And I click one of the level three links
		Then I am taken to the correct page

	Scenario: Search bar
		Given I navigate to the Homepage
		And I click on search
		Then The search bar should open

	Scenario: Valid search term
		Given I navigate to the Homepage
		And I click on search
		And I enter a valid search term
		Then I should be taken to the search results for that term

	Scenario: Valid search term
		Given I navigate to the Homepage
		And I click on search
		And I enter an invalid search term
		Then I should not be shown any search results
