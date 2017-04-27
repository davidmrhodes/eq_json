class EqualJsonArray

  def itemEqual?(item1, item2)
    return false unless item1.class == item2.class

    case item1
      when Array
        arraysMatch?(item1, item2)
      when Hash
        hashesMatch?(item1, item2)
      else
        item1 == item2
    end
  end

  private

  def arraysMatch?(actual, expected)
    return false unless actual.length == expected.length
    expected.all? do |expectedItem|
      actual.any? do |candidate|
        itemEqual?(candidate, expectedItem)
      end
    end
  end

  def hashesMatch?(actual, expected)
    return false unless arraysMatch?(actual.keys, expected.keys)
    expected.all? do |expectedKey, expectedValue|
      itemEqual?(actual[expectedKey], expectedValue)
    end
  end
end
