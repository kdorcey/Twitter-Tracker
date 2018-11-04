Feature: have successful user sign up and login

  As a person,
  I want users to be able to log in or create an account for "The Emotions of Twitter",
  so that they may interact with the SaaS application and save data to their user account.

  Background: users have been added to "The Emotions Of Twitter"

    Given the following users have signed up for "The Emotions of Twitter":
      | user_name | email                    | password   | country      |
      | kylel     | kyle-levy@uiowa.edu      | levypass   | Mars         |
      | markusd   | markus-drealan@uiowa.edu | markuspass | Canada       |
      | kyled     | kyle-dorcey@uiowa.edu    | dorceypass | Rhode Island |
      | evanm     | evan-meyer@uiowa.edu     | evanpass   | The Moon     |
      | darreng   | darren-goh@uiowa.edu     | darrenpass | Rhode Island |

