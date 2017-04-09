require 'pp'
class EqualWithOutOrderJson
  def initialize(actual_dmr)
    @actual_dmr = actual_dmr
  end

  def matches?(expected)
    @expected = expected
    expected == @actual_dmr
  end

  def failure_message
    expectedJsonTest=@expected.to_json;

    return "actual does not contain author: \"J.K. Rowling\"\n" +
           "Expected: #{expectedJsonTest}"
  end

  def failure_message_when_negated
    "Expeced failure_message_when_nagated"
  end

  def description
    "Excpect {@expected}"
  end

  # def differ
  #   RSpec::Support::Differ.new(
  #       :object_preparer => lambda { |object| RSpec::Matchers::Composable.surface_descriptions_in(object) },
  #       :color => RSpec::Matchers.configuration.color?
  #   )
  # end

  # private
  #
  # def pretty_printed_xml
  #   xml_document.to_xml(indent: 2)
  # end
  #
  # def xml_document
  #   @xml_document ||= Nokogiri::XML(@str)
  # end
end

def eq_wo_order_json(*args)
  EqualWithOutOrderJson.new(*args)
end
# RSpec::Matchers.define :eq_wo_order_json do |expected|
#   # diffable
#
#   match do |actual|
#     eq_wo_order_json(actual, expected)
#   end
#
#   def eq_wo_order_json(actual, expected)
#     return false unless actual.class == expected.class
#
#     case actual
#       when Array
#         puts 'Array '
#         pp actual
#         arrays_match?(actual, expected)
#       when Hash
#         puts 'Hash '
#         pp actual
#         hashes_match?(actual, expected)
#       else
#         actual == expected
#     end
#   end
#
#   failure_message do |actual|
#     dmr = JSON.parse(expected.to_json)
#     jj dmr
#     "expected #{dmr} json, got #{actual}"
#   end
#
#   def arrays_match?(actual, expected)
#     return false unless actual.length == expected.length
#     expected.all? do |expected_item|
#       actual.any? do |candidate|
#         eq_wo_order_json(candidate, expected_item)
#       end
#     end
#   end
#
#   def hashes_match?(actual, expected)
#     return false unless arrays_match?(actual.keys, expected.keys)
#     expected.all? do |expected_key, expected_value|
#       eq_wo_order_json(actual[expected_key], expected_value)
#     end
#   end
# end
