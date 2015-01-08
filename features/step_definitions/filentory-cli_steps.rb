# Put your step definitions here
When(/^I run "(.*?)" for the test data$/) do |arg1|
  @output = `filentory-cli "testrun" test/integration/data -t DVD --log-level fatal`
end

Then(/^I should get JSON as output$/) do
  @output.should have_json_path("name")
  @output.should have_json_path("files")
  @output.should have_json_path("mediatype")
end

Then(/^the "(.*?)" should be "(.*?)"$/) do |key, value|
  steps "And the JSON response at \"#{key}\" should be \"#{value}\""
end

Then(/^there should be (\d+) entries in "(.*?)"$/) do |number, path|
  steps "And the JSON at \"#{path}/0\" should have #{number} entries"
end

Then(/^the first file should be placed in the root folder$/) do
   steps %q{
    And the JSON at "files/0/0/name" should be "fileA.txt"
    And the JSON at "files/0/0/path" should be "."
   }
end

Then(/^the second file should be in the "(.*?)"$/) do |folder_name|
  steps %Q{
    And the JSON at "files/0/1/name" should be "fileB.txt"
    And the JSON at "files/0/1/path" should be "#{folder_name}"
   }
end

Then(/^the image file should have metadata$/) do
  steps %Q{
    And the JSON at "files/0/2/metadata" should be a hash
    And the JSON at "files/0/2/metadata" should have 7 entries
    And the JSON at "files/0/2/metadata/exif.artist" should be "Johnny Graber"
    And the JSON at "files/0/2/metadata/exif.date_time" should be "2013-11-02T18:10:43+00:00"
  }
end

Then(/^the video file should have metadata$/) do
  steps %q{
    And the JSON at "files/0/3/metadata" should be a hash
    And the JSON at "files/0/3/metadata/audio_codec" should be "aac"
    And the JSON at "files/0/3/metadata/creation_time" should be "2014-01-09T14:21:30+00:00"
  }
end

When(/^I run "(.*?)" with a server parameter$/) do |arg1|
  @output_send_ok = `filentory-cli "testrun" test/integration/data http://localhost:9292/ok -t DVD --log-level fatal`
end

Then(/^I should get a message that the data was send successfully$/) do
  @output_send_ok.should include "successfull"
end

When(/^I run "(.*?)" with the wrong server parameter$/) do |arg1|
  @output_send_ok = `filentory-cli "testrun" test/integration/data http://localhost:5555 -t DVD --log-level fatal`
end

Then(/^I should get a message that the data could not be sent$/) do
  @output_send_ok.should include "failed"
end

When(/^I run "(.*?)" with a server parameter and a yaml file$/) do |arg1|
  @output_send_ok = `filentory-cli "testrun" test/integration/data http://localhost:9292/ok -t DVD --log-level fatal --auth features/support/auth.yaml`
end

Then(/^I should get a message that "(.*?)" was send with the JSON data$/) do |value|
  @output_send_ok.should include value
end

def last_json
  @output
end
