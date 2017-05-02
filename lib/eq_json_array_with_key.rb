require 'pp'
require 'message_generator'
require 'debug_dumper'
require 'eq_json'

class EqualJsonArrayWithKey

  def initialize(expected, key)
    @expected = expected
    @key = key

  end

  def matches?(actual)
    @actual = actual

    @expected.each() do |expectedItem|
      actualItem = actual.find {|item| item[@key] == expectedItem[@key]}
      @eqJsonMatcher=EqualJson.new(expectedItem)
      if !@eqJsonMatcher.matches?(actualItem)
        generateFailureMessage(expectedItem)
        return false;
      end
    end

    return true;
  end

  def failure_message
    return @failureMessage
  end

  private

  def generateFailureMessage(expectedItem)
    @failureMessage="#{@key} #{expectedItem[@key]}\n" +
        @eqJsonMatcher.failure_message
  end


end

def eq_json_array_with_key(*args)
  EqualJsonArrayWithKey.new(*args)
end