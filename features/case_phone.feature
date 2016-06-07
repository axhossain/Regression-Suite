@phone
Feature: Ensure Phone case specific behaviors


  Scenario: Reply to an Phone case
    Given I am signed into the application
    And I open the "Phone Channel" filter
    And I go to the conversation view of a case
    Then I should be able to add a reply to the case

  Scenario: Reply and resolve an Phone case
    Given I am signed into the application
    And I open the "Phone Channel" filter
    And I open a case that is not "Resolved"
    And I should be able to add a reply and resolve to the case
    Then I go to detailed view and verify the "Status" should be "Resolved"

  Scenario: Edit the Status of a case
    Given I am signed into the application
    And I open the "Phone Channel" filter
    And I go to the detailed view of a case
    And I edit the Status of a case
    Then the Status should change

  Scenario: Add a note to Phone case
    Given I am signed into the application
    And I open the "Phone Channel" filter
    And I go to the conversation view of a case
    Then I should be able to add a note to the case

  @ios @macros @wip
  Scenario: Should be able to use a macro on a Phone case
    Given I am signed into the application
    And I open the "Phone Channel" filter
    And I go to the conversation view of a case
    And I should be able to preview macro "Thanks for feedback + Resolve"
    Then I should be able to apply a macro

  @ios @macros @wip
  Scenario: Should be able to use a macro and resolve a Phone case
    Given I am signed into the application
    And I open the "Phone Channel" filter
    And I go to the conversation view of a case
    And I should be able to preview macro "More info + Pending"
    Then I should be able to apply and resolve a macro
