 @company
Feature: Check company profile

  Scenario: Open a case and check the company profile
    Given I am signed into the application
    And I search for and open case "Company Profile"
    Then I should see the company profile for "Company Profile"