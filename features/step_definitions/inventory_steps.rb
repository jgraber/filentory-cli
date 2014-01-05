# Put your step definitions here
When(/^I run "(.*?)" for the test data$/) do |arg1|
  @output = `inventory "testrun" test/integration/data -t DVD --log-level fatal`
end

Then(/^I should get JSON as output$/) do
  @output.should have_json_path("name")
  @output.should have_json_path("files")
  @output.should have_json_path("type")
end

def last_json
  @output
end
