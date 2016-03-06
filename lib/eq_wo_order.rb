RSpec::Matchers.define :eq_wo_order do |expected|
  match do |actual|
    eq_wo_order_base(actual, expected)
  end

  def eq_wo_order_base(actual, expected)
    if actual.class == Array
      # arrays
      actual_array_items = actual.find_all { |x| x.class == Array }
      expected_array_items = expected.find_all { |x| x.class == Array }
      array_items_match = all_items_in_source?(actual_array_items, expected_array_items) &&
        all_items_in_source?(expected_array_items, actual_array_items)

      # hashes
      actual_hash_items = actual.find_all { |x| x.class == Hash }
      expected_hash_items = expected.find_all { |x| x.class == Hash }
      hash_items_match = all_items_in_source?(actual_hash_items, expected_hash_items) &&
        all_items_in_source?(expected_hash_items, actual_hash_items)

      # primitives
      actual_primitive_items = actual.find_all { |x| x.class != Hash && x.class != Array }
      expected_primitive_items = expected.find_all { |x| x.class != Hash && x.class != Array }
      primitive_items_match = sort_as_s(actual_primitive_items) == sort_as_s(expected_primitive_items)

      return primitive_items_match && array_items_match && hash_items_match
    elsif actual.class == Hash
      return all_items_in_source?(actual, expected) &&
        all_items_in_source?(expected, actual)
    else
      return actual == expected
    end
  end

  # given one array of arrays/hashes
  # and another array of arrays/hashes
  # are all the items of the first found in the second?
  def all_items_in_source?(search, source)
    search.map { |search_item|
      found = false

      source.each do |source_item|
        eq_wo_order_base = eq_wo_order_base search_item, source_item
        found = true if eq_wo_order_base
      end

      found
    }.all?
  end

  def sort_as_s(arr)
    arr.sort { |x, y| x.to_s <=> y.to_s }
  end
end
