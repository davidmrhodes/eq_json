require 'pp'
require 'colorizer'
require 'message_generator'

class EqualWithOutOrderJson

  attr_accessor :actual, :expected, :jsonPath, :jsonPathRoot, :currentActualObj,
                :currentExpectedObj, :currentJsonKey

  def initialize(actual)
    @actual = actual
    @jsonPathRoot = "$."
    @jsonPath = @jsonPathRoot
    @colorizer = EqJsonColorizer.new
    @messageGenerator = EqJsonMessageGenerator.new(self)
  end

  def matches?(expected)

    @expected = expected

    matchesObject?(@expected, @actual)

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

  def matchesObject?(expectedObj, actualObj)

    @currentActualObj = actualObj
    @currentExpectedObj = expectedObj

    case actualObj
      when Array
        return arrays_match?(expectedObj, actualObj)
      when Hash
        return hashes_match?(expectedObj, actualObj)
      else
        unless expectedObj == actualObj
          @failureMessage = @messageGenerator.generateDifferentValueMessage();
          return false;
        end
    end

    return true;

  end

  def arrays_match?(expectedObj, actualArray)

    unless actualArray.class == expectedObj.class
      @failureMessage = @messageGenerator.generateTypeMissMatchFailureMessage()
      return false;
    end

    unless actualArray.length == expectedObj.length
      @failureMessage = @messageGenerator.generateLengthFailureMessage();
      return false;
    end

    expectedObj.all? do |expected_item|
      actualArray.any? do |candidate|
        matchesObject?(expected_item, candidate)
      end
    end

  end

  def hashes_match?(expectedObj, actualHash)

    unless actualHash.class == expectedObj.class
      @failureMessage = @messageGenerator.generateTypeMissMatchFailureMessage()
      return false;
    end

    unless actualHash.length == expectedObj.length
      @failureMessage = @messageGenerator.generateLengthFailureMessage();
      return false;
    end

    expectedObj.each do |expected_key, expected_value|
      @currentJsonKey = expected_key
      @jsonPath = addKeyToPath(expected_key)
      actualValue = actualHash[expected_key]
      if actualValue.nil?
        @failureMessage = @messageGenerator.generateDifferentKeyMessage()
        return false
      end
      match = matchesObject?(expected_value, actualHash[expected_key])
      @jsonPath = removeKeyFromPath(expected_key)
      if match == false
        return false;
      end
    end

      return true

  end

  def addKeyToPath(jsonKey)
    if @jsonPath[@jsonPath.length-1] != "."
      @jsonPath << "."
    end
    @jsonPath << "#{jsonKey}"
  end

  def removeKeyFromPath(jsonKey)
    @jsonPath = @jsonPath[0, @jsonPath.length - "#{jsonKey}".length]
  end

end

def eq_wo_order_json(*args)
  EqualWithOutOrderJson.new(*args)
end
