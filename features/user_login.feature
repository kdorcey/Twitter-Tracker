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

  Scenario: happy sign-up user
    Given I am on the signup page
    When I choose to create a user with the username "cucumber", email "cucumber@gmail.com", password "pickled", verify password "pickled", and country "Canada"
    Then The login page should welcome user "cucumber"

  Scenario: sign-up username conflict
    Given I am on the signup page
    When I choose to create a user with the username "kylel", email "cucumber@gmail.com", password "pickled", verify password "pickled", and country "Canada"
    Then The same page should display a "username exists!" error

  Scenario: sign-up username invalid
    Given I am on the signup page
    When I choose to create a user with the username "a", email "cucumber@gmail.com", password "pickled", verify password "pickled", and country "Canada"
    Then The same page should display a "Invalid Username!" error

  Scenario: sign-up email conflict
    Given I am on the signup page
    When I choose to create a user with the username "cucumber", email "kyle-levy@uiowa.edu", password "pickled", verify password "pickled", and country "Canada"
    Then The same page should display a "email exists!" error

  Scenario: sign-up email invalid
    Given I am on the signup page
    When I choose to create a user with the username "cucumber", email "a", password "pickled", verify password "pickled", and country "Canada"
    Then The same page should display a "Invalid Email!" error

  Scenario: password and verify password do not much on signup
    Given I am on the signup page
    When I choose to create a user with the username "cucumber", email "cucumber@gmail.com", password "pickled", verify password "fermented", and country "Canada"
    Then The same page should display a "Passwords do not match!" error

  Scenario: happy login
    Given I am on the login page
    When I choose to login with the username "kylel" and the password "levypass"
    Then My homepage should welcome me as "kylel"

  Scenario: sad login
    Given I am on the login page
    When I choose to login with the username "afdasdfas" and the password "this_password_definitely_won't_work"
    Then The same page should display a "Invalid username/password combination." error
