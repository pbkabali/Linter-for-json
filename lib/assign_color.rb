module Color
  def add_color(color_code, value)
    "\e[#{color_code}m#{value}\e[0m"
  end

  def red(value)
    add_color(31, value)
  end

  def green(value)
    add_color(32, value)
  end

  def yellow(value)
    add_color(33, value)
  end
end
