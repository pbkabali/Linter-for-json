module Color
  def self.add_color(color_code, value)
    "\e[#{color_code}m#{value}\e[0m"
  end

  def self.cyan(value)
    add_color(36, value)
  end

  def self.green(value)
    add_color(32, value)
  end

  def self.red(value)
    add_color(31, value)
  end

  def yellow(value)
    Color.add_color(33, value)
  end
end
