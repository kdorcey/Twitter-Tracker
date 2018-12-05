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

  Scenario: happy search
    Given I am on the login page
    When I choose to login with the username "kylel" and the password "levypass"
    Then My homepage should welcome me as "kylel"
    Given I am on the main page
    When I make a search with search term "ABC", twitter handle "@evanmeyer07", and time range "Past week"
    Then I should see the term searched "ABC" in the table

  Scenario: sad search
    Given I am on the main page
    When I make a search without a search term but with a handle "@evanmeyer07" and time "Past day"
    Then The search page should flash notice the user

#  Scenario:  Search a keyword (Declarative)
#    When I have search a term "Ruby" in the "Past 2 days"
#    Then I should see a search list entry with title "Ruby" and the number of times tweeted in a time frame
