class PageFactory
  include Singleton

  PAGE_MAP = {}

  def page(_class)
    _class_name = _class.name.to_s
    PAGE_MAP[_class_name] ||= _class.new
  end

  def clear
    PAGE_MAP.clear
  end

end