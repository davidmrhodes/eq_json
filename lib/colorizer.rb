class EqJsonColorizer
  def initialize
  end

  def green(text)
    return colorize(text, 32);
  end

  def red(text)
    colorize(text, 31)
  end

  def blue(text)
    colorize(text, 34)
  end

  private

  def colorize(text, colorCode)
    "\e[#{colorCode}m#{text}\e[0m"
  end

end
