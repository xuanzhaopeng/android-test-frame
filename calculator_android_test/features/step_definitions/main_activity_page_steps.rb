def main_activity_page
  PageFactory.instance.page(MainActivityPage)
end

Given /^I see main activity page$/ do
  expect(main_activity_page.wait_until_visible('first argument with text', 'First argument')).to be true
  expect(main_activity_page.wait_until_visible('second argument with text', 'Second argument')).to be true
  expect(main_activity_page.wait_until_visible('result')).to be true
  expect(main_activity_page.wait_until_visible('add button')).to be true
  expect(main_activity_page.wait_until_visible('sub button')).to be true
  expect(main_activity_page.wait_until_visible('division button')).to be true
  expect(main_activity_page.wait_until_visible('multiplication button')).to be true
end

When /^I calculate ([^(*|+|\/)]+)\s*(\+|-|\*|\/)\s*([^(*|+|\/)]+)$/ do |arg1, op, arg2|
  main_activity_page.type(main_activity_page.clear_text, arg1, 'first argument')
  main_activity_page.type(main_activity_page.not_clear_text, arg2, 'second argument')
  main_activity_page.tap_on(main_activity_page.convert_op(op))
end

When /^I( clear text and)? type (.*) to (first|second) argument$/ do |clear_text, value, ele|
  main_activity_page.type(!clear_text.nil?, value, "#{ele} argument")
end

When /^I tap on (add|sub|division|multiplication) button$/ do |ele|
  main_activity_page.tap_on("#{ele} button")
end

Then /^I see the text of (first argument|second argument|result) is (.*)$/ do |ele, value|
  expect(main_activity_page.wait_until_visible("#{ele} with text", value)).to be true
end