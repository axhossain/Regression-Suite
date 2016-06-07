@customer
Feature: Check customer profile

  Scenario: Open a case and check the customer profile
    Given I am signed into the application
    And I search for and open case "Company Profile"
    Then I should see the customer profile for "Company Profile"