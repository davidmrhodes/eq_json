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

    unless expected == @actual
      @failureMessage = generateNotEqualMessage();
      return false;
    end

    return true;
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

     return getExpectedActualJson() +"\n" +
            "Diff:\n" +
            "JSON path $. expected #{expectedType} type but actual is #{actualType}\n"
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

  def generateNotEqualMessage()

    objectsNotInExpected = getObjectsNotIn(@actual, @expected);

    objectsNotInActual = getObjectsNotIn(@expected, @actual);

    jsonErrorInfo = "JSON path $.\n"

    unless objectsNotInExpected.empty?
      jsonErrorInfo << "expected does not contain #{objectsNotInExpected.to_json}\n"
    end

    unless objectsNotInActual.empty?
      jsonErrorInfo << makeGreen("actual does not contain #{objectsNotInActual.to_json}")
    end

    differ = RSpec::Support::Differ.new

    differ = RSpec::Support::Differ.new(
          :object_preparer => lambda { |expected| RSpec::Matchers::Composable.surface_descriptions_in(expected) },
          :color => RSpec::Matchers.configuration.color?
    )

    @difference = differ.diff(@expected, @actual)

    return getExpectedActualJson() + "\n" +
           "\nDiff:\n" +
           jsonErrorInfo +
           @difference
  end

  def getExpectedActualJson
    expectedJson=@expected.to_json;
    actualJson=@actual.to_json;

    return "Expected: #{expectedJson}\n" +
           makeGreen("Actual: #{actualJson}")
  end

  def getObjectsNotIn(hash1, hash2)
    missing = {}
    hash1.each do |hash1_key, hash1_value|
      unless hash2.has_key?(hash1_key)
        missing[hash1_key] = hash1_value
      end
    end
    return missing
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
