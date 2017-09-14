class MainActivityPage < BasePage

  ARG1_LOCATOR = "@content-desc='arg1'"
  ARG2_LOCATOR = "@content-desc='arg2'"
  RESULT_LOCATOR = "@content-desc='result'"

  FIRST_ARGUMENT = "//*[#{ARG1_LOCATOR} and @text='First argument']"
  SECOND_ARGUMENT = "//*[#{ARG2_LOCATOR} and @text='Second argument']"
  RESULT = "//*[#{RESULT_LOCATOR} and @text='Result']"
  ADD_BUTTON = "//*[@content-desc='addition']"
  SUB_BUTTON = "//*[@content-desc='subtraction']"
  DIVISION_BUTTON = "//*[@content-desc='division']"
  MULTIPLICATION_BUTTON = "//*[@content-desc='multiplication']"

  FIRST_ARGUMENT_WITH_TEXT = "//*[#{ARG1_LOCATOR} and @text='%s']"
  SECOND_ARGUMENT_WITH_TEXT = "//*[#{ARG2_LOCATOR} and @text='%s']"
  RESULT_WITH_TEXT = "//*[#{RESULT_LOCATOR} and @text='%s']"

  def convert_op(op)
    case op
      when '+'
        'ADD BUTTON'
      when '-'
        'SUB BUTTON'
      when '/'
        'DIVISION BUTTON'
      when '*'
        'MULTIPLICATION BUTTON'
      else
        raise "Unknown op '#{op}'"
    end
  end

end