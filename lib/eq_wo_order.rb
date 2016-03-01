RSpec::Matchers.define :eq_wo_order do |expected|
  match do |actual|
    eq_wo_order_base(actual, expected)
  end

  def eq_wo_order_base(actual, expected)
    if actual.class == Array
      actual_sorted = sort_array_of_hashes_by_all_keys actual
      expected_sorted = sort_array_of_hashes_by_all_keys expected

      actual_sorted == expected_sorted
    else
      actual == expected
    end
  end

  def sort_array_of_hashes_by_all_keys(arr)
    sorted_arr = []

    hash_items = arr.collect { |x| x if x.class == Hash }.compact
    array_items = arr.collect { |x| x if x.class == Array }.compact
    primitive_items = arr.collect { |x| x unless x.class == Hash || x.class == Array }.compact

    # primitives
    sorted_arr.push primitive_items.sort.flatten

    # arrays
    sorted_array_items = array_items.collect { |item| sort_array_of_hashes_by_all_keys(item) }
    sorted_arr.push sorted_array_items.flatten

    # hashes
    intersect_keys(hash_items).each do |key|
      hash_items = hash_items.sort_by { |item| item[key] }
    end
    sorted_arr.push hash_items.flatten

    sorted_arr
  end

  def intersect_keys(arr_of_hashes)
    keys = arr_of_hashes.collect { |x| x.keys }
    intersected_keys = keys.reduce(keys.first, :&)
    intersected_keys == nil ? [] : intersected_keys
  end
end
