@twitter
Feature: Ensure twitter case specific behaviors
  
  @wip
  Scenario: Mention to a twitter case
    Given I am signed into the application
    And I open the "Twitter Channel" filter
    And I go to the conversation view of a case
    Then I should be able to add a mention to the case with max characters

  @wip
  Scenario: Mention to a twitter case and attempting to send more than 140 characters
    Given I am signed into the application
    And I open the "Twitter Channel" filter
    And I go to the conversation view of a case
    Then I should not be able to add a mention to the case with more than max characters

  @ios @wip
  Scenario: DM to a twitter case
    Given I am signed into the application
    And I open the "Twitter Channel" filter
    And I go to the conversation view of a case
    Then I should be able to add a dm to the case with max characters

  @ios @wip
  Scenario: DM to a twitter case and attempting to send more than 140 characters
    Given I am signed into the application
    And I open the "Twitter Channel" filter
    And I go to the conversation view of a case
    Then I should not be able to add a dm to the case with more than max characters

  @wip
  Scenario: Mention and Resolve to a twitter case
    Given I am signed into the application
    And I open the "Twitter Channel" filter
    And I open a case that is not "Resolved"
    And I should be able to add a mention and resolve to the case with max characters
    Then I go to detailed view and verify the "Status" should be "Resolved"

  @ios @wip
  Scenario: DM and Resolve to a twitter case
    Given I am signed into the application
    And I open the "Twitter Channel" filter
    And I open a case that is not "Resolved"
    And I should be able to add a dm and resolve to the case with max characters
    Then I go to detailed view and verify the "Status" should be "Resolved"


