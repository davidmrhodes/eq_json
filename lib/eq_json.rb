require 'pp'
require 'message_generator'
require 'eq_json_array'
require 'debug_dumper'

class EqualJson

  attr_accessor :actual, :expected, :jsonPath, :jsonPathRoot, :currentActualObj,
                :currentExpectedObj, :currentJsonKey

  def initialize(expected)
    @expected = expected
    @jsonPathRoot = "$."
    @jsonPath = @jsonPathRoot
    @messageGenerator = EqJsonMessageGenerator.new(self)
  end

  def matches?(actual)
    @actual = actual

    matchesObject?(@expected, @actual)
  end

  def failure_message
    if RSpec.configuration.methods.include? :json_debug_config
      if RSpec.configuration.json_debug_config?
        debugDumper = EqJsonDebugDumper.new(self)
        debugDumper.dump()
      end
    end
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

    expectedObj.each do |expectedItem|

      expectedCount = expectedObj.count do |item|
        arrayUtil.itemEqual?(expectedItem, item)
      end

      actualCount = actualArray.count do |candidate|
        arrayUtil.itemEqual?(expectedItem, candidate)
      end

      if expectedCount != actualCount
        @failureMessage = @messageGenerator.generateExpectedItemNotFoundInArray(expectedItem, expectedCount, actualCount)
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

    expectedObj.each do |expectedKey, expectedValue|
      @currentJsonKey = expectedKey
      actualValue = actualHash[expectedKey]
      if actualValue.nil?
        @currentActualObj = actualHash
        @currentExpectedObj = expectedObj
        @failureMessage = @messageGenerator.generateDifferentKeyMessage()
        return false
      end

      addKeyToPath(expectedKey)
      match = matchesObject?(expectedValue, actualHash[expectedKey])
      removeKeyFromPath(expectedKey)
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
  EqualJson.new(*args)
end


