require 'colorizer'

class ArrayWithKeyMessageGen

  def initialize(matcher)
    @matcher = matcher
    @colorizer = EqJsonColorizer.new
  end

  def generateFailureMessage(expectedItem, eqFailureMessage)
    return "#{@matcher.key} #{expectedItem[@matcher.key]}\n" +
        eqFailureMessage
  end

  def generateExpectedNotInActual(expectedItem)
    return "#{@matcher.key} #{expectedItem[@matcher.key]} not found in actual\n" +
        "Expected: #{expectedItem.to_json}\n"
  end

  def generateDifferentSizeArrays()
    objectsNotInExpected = getObjectsNotIn(@matcher.actual, @matcher.expected);
    objectsNotInActual = getObjectsNotIn(@matcher.expected, @matcher.actual);

    jsonErrorInfo = "Array size does not match. Expected #{@matcher.expected.length} actual #{@matcher.actual.length}\n"

    unless objectsNotInExpected.empty?
      jsonErrorInfo << "expected does not contain #{@matcher.key}s #{objectsNotInExpected}\n"
    end

    unless objectsNotInActual.empty?
      jsonErrorInfo << "actual does not contain #{objectsNotInActual}\n"
    end

    return jsonErrorInfo
  end

  def getObjectsNotIn(array1, array2)
    missing = []
    array1.each do |item1|
      item2 = array2.find {|item| item[@matcher.key] == item1[@matcher.key]}
      if item2.nil?
        missing.push(item1[@matcher.key])
      end
    end
    return missing
  end
end

