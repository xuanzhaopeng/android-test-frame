class BasePage
  DEFAULT_TIMEOUT = DemoCommonLib::TimeDelta.seconds(5)
  DEFAULT_WAIT_INTERVAL = DemoCommonLib::TimeDelta.seconds(1)

  def type(value, xpath_name, *xpath_params)
    str = locator_eval(xpath_name)
    xpath = str % xpath_params
    DemoCommonLib::WaitHelper.wait {
      $driver.find_element(:xpath, xpath).click
      `adb shell input text #{value}`
    }
  end

  def tap_on(xpath_name, *xpath_params)
    str = locator_eval(xpath_name)
    xpath = str % xpath_params
    DemoCommonLib::WaitHelper.wait {
      $driver.find_element(:xpath, xpath).click
    }
  end

  def wait_until_visible(xpath_name, *xpath_params)
    wait_until_visible_timeout(DEFAULT_TIMEOUT, xpath_name, *xpath_params)
  end

  def wait_until_visible_timeout(timeout_delta, xpath_name, *xpath_params)
    str = locator_eval(xpath_name)
    xpath = str % xpath_params
    p "Wait until visible {xpath: #{xpath}}" if $demo_debug
    DemoCommonLib::WaitHelper.wait_true(timeout_delta, DEFAULT_WAIT_INTERVAL) {
      $driver.find_element(:xpath, xpath).displayed?
    }
  end

  private
  def locator_eval(xpath_name)
    eval("#{self.class.to_s}::#{xpath_name.upcase.tr(' ', '_') }")
  end
end