def main_activity_page
  PageFactory.instance.page(MainActivityPage)
end

Given /^I see main activity page$/ do
  expect(main_activity_page.wait_until_visible('first argument')).to be true
  expect(main_activity_page.wait_until_visible('second argument')).to be true
  expect(main_activity_page.wait_until_visible('result')).to be true
  expect(main_activity_page.wait_until_visible('add button')).to be true
  expect(main_activity_page.wait_until_visible('sub button')).to be true
  expect(main_activity_page.wait_until_visible('division button')).to be true
  expect(main_activity_page.wait_until_visible('multiplication button')).to be true
end

When /^I calculate (\d+)(\+|-|\*|\/)(\d+)$/ do |arg1, op, arg2|
  main_activity_page.type(arg1, 'first argument')
  main_activity_page.type(arg2, 'second argument')
  main_activity_page.tap_on(main_activity_page.convert_op(op))
end

When /^I type (.*) to (first|second) argument$/ do |value, ele|
  main_activity_page.type(value, "#{ele} argument")
end

When /^I tap on (add|sub|division|multiplication) button$/ do |ele|
  main_activity_page.tap_on("#{ele} button")
end

Then /^I see the text of (first argument|second argument|result) is (.*)$/ do |ele, value|
  expect(main_activity_page.wait_until_visible("#{ele} with text", value)).to be true
end