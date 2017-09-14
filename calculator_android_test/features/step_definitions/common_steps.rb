Given /^I wait for (\d+) seconds?$/ do |seconds|
  sleep seconds.to_i
end

Given /^I set scenario key "(.*)"$/ do |key|
  $current_scenario_key = key
end
