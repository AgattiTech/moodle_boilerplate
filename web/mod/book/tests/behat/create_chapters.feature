@mod @mod_book
Feature: In a book, create chapters and sub chapters
  In order to create chapters and subchapters
  As a teacher
  I need to add chapters and subchapters to a book.

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | format |
      | Course 1 | C1 | topics |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
    And the following "activities" exist:
      | activity | course | name      | section |
      | book     | C1     | Test book | 1       |
    And the following "mod_book > chapter" exists:
      | book    | Test book                       |
      | title   | Dummy first chapter             |
      | content | Dream is the start of a journey |
    And I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on

  Scenario: Create chapters and sub chapters and navigate between them
    Given I am on the "Test book" "book activity" page
    And I should see "1. Dummy first chapter" in the "Table of contents" "block"
    And I click on "Add new chapter after \"Dummy first chapter\"" "link" in the "Table of contents" "block"
    And I should see "Dummy first chapter"
    And I set the following fields to these values:
      | Chapter title | Dummy second chapter |
      | Content | The path is the second part |
    And I press "Save changes"
    And I should see "2. Dummy second chapter" in the "Table of contents" "block"
    And I click on "Add new chapter after \"Dummy first chapter\"" "link" in the "Table of contents" "block"
    And I should see "Dummy first chapter"
    And I set the following fields to these values:
      | Chapter title | Dummy first subchapter |
      | Content | The path is the second part |
      | Subchapter | true |
    And I press "Save changes"
    And I should see "1.1. Dummy first subchapter" in the "Table of contents" "block"
    And I should see "1. Dummy first chapter" in the ".book_content" "css_element"
    And I should see "1.1. Dummy first subchapter" in the ".book_content" "css_element"
    And I click on "Next" "link"
    And I should see "2. Dummy second chapter" in the ".book_content" "css_element"
    And I should see "2. Dummy second chapter" in the "strong" "css_element"
    And I should not see "Next" in the ".book_content" "css_element"
    And I click on "Exit book" "link"
    And I should see "Test book" in the "Topic 1" "section"
    And I follow "Test book"
    And I should not see "Previous" in the ".book_content" "css_element"
    And I should see "1. Dummy first chapter" in the "strong" "css_element"
    When I click on "Next" "link"
    Then I should see "1.1. Dummy first subchapter" in the ".book_content" "css_element"
    And I should see "1.1. Dummy first subchapter" in the "strong" "css_element"
    And I click on "Previous" "link"
    And I should see "1. Dummy first chapter" in the ".book_content" "css_element"
    And I should see "1. Dummy first chapter" in the "strong" "css_element"

  Scenario: Change editing mode for an individual chapter
    Given I am on the "Test book" "book activity" page
    And I should see "1. Dummy first chapter" in the "Table of contents" "block"
    And "Edit chapter \"1. Dummy first chapter\"" "link" should exist in the "Table of contents" "block"
    And "Delete chapter \"1. Dummy first chapter\"" "link" should exist in the "Table of contents" "block"
    And "Hide chapter \"1. Dummy first chapter\"" "link" should exist in the "Table of contents" "block"
    And "Add new chapter" "link" should exist in the "Table of contents" "block"
    When I press "Turn editing off"
    Then "Edit chapter \"1. Dummy first chapter\"" "link" should not exist in the "Table of contents" "block"
    And "Delete chapter \"1. Dummy first chapter\"" "link" should not exist in the "Table of contents" "block"
    And "Hide chapter \"1. Dummy first chapter\"" "link" should not exist in the "Table of contents" "block"
    And "Add new chapter after \"Dummy first chapter\"" "link" should not exist in the "Table of contents" "block"
