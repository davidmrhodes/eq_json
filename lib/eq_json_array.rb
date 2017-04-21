class EqualJsonArray

  def itemEqual?(item1, item2)
    return false unless item1.class == item2.class

    case item1
      when Array
        arrays_match?(item1, item2)
      when Hash
        hashes_match?(item1, item2)
      else
        item1 == item2
    end
  end

  def arrays_match?(actual, expected)
    return false unless actual.length == expected.length
    expected.all? do |expected_item|
      actual.any? do |candidate|
        itemEqual?(candidate, expected_item)
      end
    end
  end

  def hashes_match?(actual, expected)
    return false unless arrays_match?(actual.keys, expected.keys)
    expected.all? do |expected_key, expected_value|
      itemEqual?(actual[expected_key], expected_value)
    end
  end
end
