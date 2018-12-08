Feature: Allow Emotions of Twitter user to search a term

  As a user,
  I want to be able to search topics within the SaaS "Emotions of Twitter" application
  to see how Twitter users feel about topics over time.

  Background: users have been added to "The Emotions Of Twitter"

    Given the following users have signed up for "The Emotions of Twitter":
      | user_name | email                    | password   | country      |
      | kylel     | kyle-levy@uiowa.edu      | levypass   | Mars         |
      | markusd   | markus-drealan@uiowa.edu | markuspass | Canada       |
      | kyled     | kyle-dorcey@uiowa.edu    | dorceypass | Rhode Island |
      | evanm     | evan-meyer@uiowa.edu     | evanpass   | The Moon     |
      | darreng   | darren-goh@uiowa.edu     | darrenpass | Rhode Island |

  Scenario: Attempt search without login
    Given I am on the main page
    When I make a search with search term "ABC", twitter handle "evanmeyer07", from date "2018/12/4", and to date "2018/12/7"
    Then The same page should display a "Nah homie, gotta make an account first." error


  Scenario: No search term has been entered
    Given I am on the login page
    When I choose to login with the username "kylel" and the password "levypass"
    Then My homepage should welcome me as "kylel"
    Given I am on the main page
    When I make a search with search term "", twitter handle "evanmeyer07", from date "2018/12/4", and to date "2018/12/7"
    Then The same page should display a "Please enter a search term & a twitter handle!" error

  Scenario: No twitter handle has been entered
    Given I am on the login page
    When I choose to login with the username "kylel" and the password "levypass"
    Then My homepage should welcome me as "kylel"
    Given I am on the main page
    When I make a search with search term "ABC", twitter handle "", from date "2018/12/4", and to date "2018/12/7"
    Then The same page should display a "Please enter a search term & a twitter handle!" error

  Scenario: No dates have been entered
    Given I am on the login page
    When I choose to login with the username "kylel" and the password "levypass"
    Then My homepage should welcome me as "kylel"
    Given I am on the main page
    When I make a search with search term "ABC", twitter handle "evanmeyer07", from date "", and to date ""
    Then The same page should display a "Enter both dates" error

  Scenario: From date comes before to date
    Given I am on the login page
    When I choose to login with the username "kylel" and the password "levypass"
    Then My homepage should welcome me as "kylel"
    Given I am on the main page
    When I make a search with search term "ABC", twitter handle "evanmeyer07", from date "2018/12/7", and to date "2018/12/4"
    Then The same page should display a "Date entered incorrectly!" error

  Scenario: One of the dates is in the future
    Given I am on the login page
    When I choose to login with the username "kylel" and the password "levypass"
    Then My homepage should welcome me as "kylel"
    Given I am on the main page
    When I make a search with search term "ABC", twitter handle "evanmeyer07", from date "2060/12/7", and to date "2018/12/4"
    Then The same page should display a "Date entered incorrectly!" error
