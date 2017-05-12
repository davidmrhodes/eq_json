require 'pp'
require 'message_generator'
require 'debug_dumper'
require 'eq_json'
require 'array_with_key_message_gen'

class EqualJsonArrayWithKey

  attr_accessor :actual, :expected, :key

  def initialize(expected, key)
    unless key.is_a? Symbol
      raise "Key should be a symbol"
    end
    @expected = expected
    @key = key
    @messageGenerator = ArrayWithKeyMessageGen.new(self)
  end

  def matches?(actual)
    @actual = actual

    unless actual.length == expected.length
      @failureMessage = @messageGenerator.generateDifferentSizeArrays()
      return false
    end

    @expected.each() do |expectedItem|
      puts "expectedItem[key] #{expectedItem[@key]}"
      if expectedItem[@key].nil?
        puts "got here dmr"
        @failureMessage = @messageGenerator.generateExpectedItemMissingKey(expectedItem)
        return false
      end

      actualItem = actual.find {|item| item[@key] == expectedItem[@key]}
      if actualItem.nil?
        @failureMessage = @messageGenerator.generateExpectedNotInActual(expectedItem)
        return false;
      end
      @eqJsonMatcher=EqualJson.new(expectedItem)
      if !@eqJsonMatcher.matches?(actualItem)
        @failureMessage = @messageGenerator.generateFailureMessage(expectedItem, @eqJsonMatcher.failure_message)
        return false;
      end
    end

    return true;
  end

  def failure_message
    return @failureMessage
  end

end

def eq_json_array_with_key(*args)
  EqualJsonArrayWithKey.new(*args)
end