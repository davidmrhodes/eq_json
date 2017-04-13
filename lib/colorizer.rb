class EqJsonColorizer
  def initialize
  end

  def green(text)
    return colorize(text, 32);
    # return "\e[32m#{text}\e[0m"
  end

  def red(text)
    colorize(text, 31)
  end

  def blue(text)
    colorize(text, 34)
  end

private

  def colorize(text, color_code)
      "\e[#{color_code}m#{text}\e[0m"
  end

end
