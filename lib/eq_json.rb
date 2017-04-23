require 'pp'
require 'message_generator'
require 'eq_json_array'

class EqualWithOutOrderJson

  attr_accessor :actual, :expected, :jsonPath, :jsonPathRoot, :currentActualObj,
                :currentExpectedObj, :currentJsonKey

  def initialize(actual)
    @actual = actual
    @jsonPathRoot = "$."
    @jsonPath = @jsonPathRoot
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
      @failureMessage = @messageGenerator.generateDifferentSizeArrayMessage();
      return false;
    end

    arrayUtil = EqualJsonArray.new

    expectedObj.each do |expected_item|

      expectedCount = expectedObj.count do |item|
          arrayUtil.itemEqual?(expected_item, item)
      end

      actualCount = actualArray.count do |candidate|
        arrayUtil.itemEqual?(expected_item, candidate)
      end

      if expectedCount != actualCount
        @failureMessage = @messageGenerator.generateExpectedItemNotFoundInArray(expected_item, expectedCount, actualCount)
        return false
      end

    end

    return true
  end

  def hashes_match?(expectedObj, actualHash)

    unless actualHash.class == expectedObj.class
      @failureMessage = @messageGenerator.generateTypeMissMatchFailureMessage()
      return false;
    end

    unless actualHash.length == expectedObj.length
      @failureMessage = @messageGenerator.generateDifferentKeyMessage();
      return false;
    end

    expectedObj.each do |expected_key, expected_value|
      @currentJsonKey = expected_key
      actualValue = actualHash[expected_key]
      if actualValue.nil?
        @currentActualObj = actualHash
        @currentExpectedObj = expectedObj
        @failureMessage = @messageGenerator.generateDifferentKeyMessage()
        return false
      end

      addKeyToPath(expected_key)
      match = matchesObject?(expected_value, actualHash[expected_key])
      removeKeyFromPath(expected_key)
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
    @jsonPath = @jsonPath[0, @jsonPath.length - "#{jsonKey}".length - 1]
    if @jsonPath == "$"
      @jsonPath << "."
    end
  end

end

def eq_json(*args)
  EqualWithOutOrderJson.new(*args)
end
