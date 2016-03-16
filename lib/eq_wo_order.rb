RSpec::Matchers.define :eq_wo_order do |expected|
  match do |actual|
    eq_wo_order(actual, expected)
  end

  def eq_wo_order(actual, expected)
    return false unless actual.class == expected.class

    case actual
      when Array
        arrays_match?(actual, expected)
      when Hash
        hashes_match?(actual, expected)
      else
        actual == expected
    end
  end

  def arrays_match?(actual, expected)
    return false unless actual.length == expected.length
    expected.all? do |expected_item|
      actual.any? do |candidate|
        eq_wo_order(candidate, expected_item)
      end
    end
  end

  def hashes_match?(actual, expected)
    return false unless arrays_match?(actual.keys, expected.keys)
    expected.all? do |expected_key, expected_value|
      eq_wo_order(actual[expected_key], expected_value)
    end
  end
end
