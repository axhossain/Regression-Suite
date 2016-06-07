@custom
Feature: Check custom field

  Scenario: Open a case and check the custom field
    Given I am signed into the application
    And I search for and open case "Company Profile"
    Then I should see the custom field for "Case Details"

