require 'pp'

class EqualWithOutOrderJson
  def initialize(actual)
    @actual = actual
  end

  def matches?(expected)
    @expected = expected

    unless @actual.class == expected.class
      @failureMessage = generateTypeMissMatchFailureMessage()
      return false;
    end

    unless @actual.length == @expected.length
      @failureMessage = generateLengthFailureMessage();
      return false;
    end

    expected == @actual
  end

  def failure_message
    return @failureMessage
  end

  def failure_message_when_negated
    "Expeced failure_message_when_nagated"
  end

  def description
    "Excpect {@expected}"
  end

  # def differ
  #   RSpec::Support::Differ.new(
  #       :object_preparer => lambda { |object| RSpec::Matchers::Composable.surface_descriptions_in(object) },
  #       :color => RSpec::Matchers.configuration.color?
  #   )
  # end

  private

  def getJsonType(rubyJsonObject)
    case rubyJsonObject
      when Array
        return "array"
      when Hash
        return "object"
      else
        return "not json"
    end
  end

  def generateTypeMissMatchFailureMessage()
    actualType = getJsonType(@actual)
    expectedType = getJsonType(@expected)

     return "JSON path [ expected #{expectedType} type but actual is #{actualType}\n" +
            getExpectedActualJson()
   end


  def generateLengthFailureMessage()

    if @actual.length > @expected.length
      smallerIs = "expected"
      larger = @actual
      smaller = @expected
    else
      smallerIs = "actual"
      larger = @expected
      smaller = @actual
    end

    difference = larger.keys - smaller.keys
    merged = larger.merge(smaller)

    diff = {}
    difference.each {|k| diff[k] = merged[k] }

    diffJson = diff.to_json

    differ = RSpec::Support::Differ.new

    differ = RSpec::Support::Differ.new(
          :object_preparer => lambda { |expected| RSpec::Matchers::Composable.surface_descriptions_in(expected) },
          :color => RSpec::Matchers.configuration.color?
      )

    @difference = differ.diff(@expected, @actual)

    return getExpectedActualJson() + "\n" +
           "Diff:\n" +
           "JSON path { #{smallerIs} does not contain #{diffJson}\n" +
           @difference
  end

  def getExpectedActualJson
    expectedJson=@expected.to_json;
    actualJson=@actual.to_json;

    return "Expected: #{expectedJson}\n" +
           makeGreen("Actual: #{actualJson}")
          #  puts "\e[32mHello\e[0m"
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
end

def eq_wo_order_json(*args)
  EqualWithOutOrderJson.new(*args)
end
