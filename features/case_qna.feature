@qna
Feature: Ensure Q&A case specific behaviors


  Scenario: Reply to an Q&A case
    Given I am signed into the application
    And I open the "Q&A Channel" filter
    And I go to the conversation view of a case
    Then I should be able to add a reply to the case

  Scenario: Reply and resolve an Q&A case
    Given I am signed into the application
    And I create a "qanda" case using "api/v2/cases" resource
    And I open the "Q&A Channel" filter
    And I open a case that is not "Resolved"
    And I should be able to add a reply and resolve to the case
    Then I go to detailed view and verify the "Status" should be "Resolved"

  @android
  Scenario: Reply and select Best Answer to a Q&A case
    Given I am signed into the application
    And I open the "Q&A Channel" filter
    And I go to the conversation view of a case
    And I should be able to add a reply and select best answer to the case
    Then I should be able to verify that reply should be best answer

  @android
  Scenario: Select Best Answer to a Q&A case
    Given I am signed into the application
    And I open the "Q&A Channel" filter
    And I go to the conversation view of a case
    And I should be able to add a reply to the case
    And I should be able to change reply to best answer
    Then I should be able to verify that reply should be best answer

  @android
  Scenario: Select Hidden Post to a Q&A case
    Given I am signed into the application
    And I open the "Q&A Channel" filter
    And I go to the conversation view of a case
    And I should be able to add a reply to the case
    And I should be able to change reply to hidden post
    Then I should be able to verify that reply should be hidden

  @android
  Scenario: Change Community Answers setting
    Given I am signed into the application
    And I open the "Q&A Channel" filter
    And I go to the detailed view of a case
    And I edit the Community Answers of a case
    Then the Community Answers should change

  Scenario: Edit the Status of a case
    Given I am signed into the application
    And I open the "Q&A Channel" filter
    And I go to the detailed view of a case
    And I edit the Status of a case
    Then the Status should change

  Scenario: Add a note to Q&A case
    Given I am signed into the application
    And I open the "Q&A Channel" filter
    And I go to the conversation view of a case
    Then I should be able to add a note to the case

  @ios @macros @wip
  Scenario: Should be able to use a macro on a Q&A case
    Given I am signed into the application
    And I open the "Q&A Channel" filter
    And I go to the conversation view of a case
    And I should be able to preview macro "Thanks for feedback + Resolve"
    Then I should be able to apply a macro

  @ios @macros @wip
  Scenario: Should be able to use a macro and resolve a Q&A case
    Given I am signed into the application
    And I open the "Q&A Channel" filter
    And I go to the conversation view of a case
    And I should be able to preview macro "More info + Pending"
    Then I should be able to apply and resolve a macro
