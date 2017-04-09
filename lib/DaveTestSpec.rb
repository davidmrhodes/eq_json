class DaveTestSpec
  def initialize(actual_dmr)
    @actual_dmr = actual_dmr
  end

  def matches?(str)
    @str = str
    puts "expected #{str} actual #{@actual_dmr}"
    str == @actual_dmr
  end

  def failure_message
    "Expected failure_message"
  end

  def failure_message_when_negated
    "Expeced failure_message_when_nagated"
  end

  def description
    "Excpect dmr test"
  end

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

def dave_test(*args)
  DaveTestSpec.new(*args)
end
