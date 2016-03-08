RSpec::Matchers.define :eq_wo_order do |expected|
  match do |actual|
    eq_wo_order_base(actual, expected)
  end

  def eq_wo_order_base(actual, expected)
    case actual
      when Array
        primitive_items_match?(actual, expected) &&
          array_items_match?(actual, expected) &&
          hash_items_match?(actual, expected)
      when Hash
        all_items_in_source?(actual, expected) && all_items_in_source?(expected, actual)
      else
        actual == expected
    end
  end

  def primitive_items_match?(actual, expected)
    actual_primitive_items = primitives(actual)
    expected_primitive_items = primitives(expected)
    sort_as_s(actual_primitive_items) == sort_as_s(expected_primitive_items)
  end

  def hash_items_match?(actual, expected)
    actual_hash_items = actual.grep(Hash)
    expected_hash_items = expected.grep(Hash)
    all_items_in_source?(actual_hash_items, expected_hash_items) &&
      all_items_in_source?(expected_hash_items, actual_hash_items)
  end

  def array_items_match?(actual, expected)
    actual_array_items = actual.grep(Array)
    expected_array_items = expected.grep(Array)
    all_items_in_source?(actual_array_items, expected_array_items) &&
      all_items_in_source?(expected_array_items, actual_array_items)
  end

  def primitives(list)
    list.find_all { |x| x.class != Hash && x.class != Array }
  end

  # given one array of arrays/hashes
  # and another array of arrays/hashes
  # are all the items of the first found in the second?
  def all_items_in_source?(search, source)
    search.map do |search_item|
      source.any? do |source_item|
        eq_wo_order_base search_item, source_item
      end
    end.all?
  end

  def sort_as_s(arr)
    arr.sort_by(&:to_s)
  end
end
