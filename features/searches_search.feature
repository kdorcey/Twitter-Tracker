Feature: Allow Emotions of Twitter user to search a term

  Scenario:  Search a keyword (Declarative)
    When I have search a term "Ruby" in the "Past 2 days"
    Then I should see a search list entry with title "Ruby" and the number of times tweeted in a time frame
