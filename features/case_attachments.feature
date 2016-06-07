@attachments @wip
Feature: Check case attachments

  Scenario Outline: Open a case and check the attachments
    Given I am signed into the application
    And I search for and open case "<attachment_name>"
    When I open each case to verify attachments
    Then I should be able to download the "big" attachments with "<attachment_name>" and "<file_size_status>"

  Examples:
  | attachment_name |    file_size_status |
  | Attachment CMA_Android_P2P-V4.0.0.0-287-Universal-09901-Debug.apk |    6.7 MB (Downloaded)   |
  | Attachment Demo.mov |    15.9 MB (Downloaded)   |
  | Attachment MACKLEMORE___RYAN_LEWIS.mp3 |    14.2 MB (Downloaded)   |

  Scenario Outline: Open a case and check the attachments
    Given I am signed into the application
    And I search for and open case "<attachment_name>"
    When I open each case to verify attachments
    Then I should be able to download the "medium" attachments with "<attachment_name>" and "<file_size_status>"

  Examples:
    | attachment_name |    file_size_status |
    | Attachment droidAtScreen-1.0.2.jar | 718 KB (Downloaded) |
    | Attachment cbs2HealthCheck.pl | 33 KB (Downloaded) |
    | Attachment IMG_3245.JPG | 1.5 MB (Downloaded) |
    | Attachment DBSync Tool Tech Spec sections.doc | 43 KB (Downloaded) |
    | Attachment reports_android.html |    163 KB (Downloaded)   |
    | Attachment simple_test.zip |    4.3 MB (Downloaded)   |

  @attachments
  Scenario Outline: Open a case and check the attachments
    Given I am signed into the application
    And I search for and open case "<attachment_name>"
    When I open each case to verify attachments
    Then I should be able to download the "small" attachments with "<attachment_name>" and "<file_size_status>"

  Examples:
    | attachment_name |    file_size_status |

    | Attachment mw_automation_notes.rtf |    13 KB (Downloaded)   |
    
