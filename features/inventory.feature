Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  Scenario: App just runs
    When I get help for "inventory"
    Then the exit status should be 0
    And the banner should be present
    And there should be a one line summary of what the app does
    And the banner should document that this app takes options
    And the following options should be documented:
      |--version|
      |--type|
    And the banner should document that this app's arguments are:
      |name||
      |path||
      |server|optional|

  Scenario: App prints JSON
    When I run "inventory" for the test data
    Then I should get JSON as output
    And the JSON response at "name" should be "testrun"
    And the JSON response at "type" should be "DVD"
    And the JSON at "files/0" should have 4 entries
    And the JSON at "files/0/0/name" should be "fileA.txt"
    And the JSON at "files/0/0/path" should be "."
    And the JSON at "files/0/1/name" should be "fileB.txt"
    And the JSON at "files/0/1/path" should be "folder"
    And the JSON at "files/0/1/path" should be "folder"
    And the JSON at "files/0/2/metadata" should be a hash
    And the JSON at "files/0/2/metadata" should have 6 entries
    And the JSON at "files/0/2/metadata/exif.artist" should be "Johnny Graber"
    And the JSON at "files/0/2/metadata/exif.date_time" should be "2013-11-02T18:10:43+00:00"
