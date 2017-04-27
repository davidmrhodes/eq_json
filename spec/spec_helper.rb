RSpec.configure do |c|
  c.order = :random
  c.default_formatter = 'doc'
  c.filter_run focus: true
  c.run_all_when_everything_filtered = true
  c.add_setting :json_debug_config
  c.json_debug_config=true
end

def makeGreen(text)
  return colorize(text, 32);
  # return "\e[32m#{text}\e[0m"
end

def makeRed(text)
  colorize(text, 31)
end

def makeBlue(text)
  colorize(text, 34)
end

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def wrapWithResetColor(text)
  "\e[0m#{text}\e[0m"
end
