require 'tmpdir'

class EqJsonDebugDumper

  def initialize(matcher)
    @matcher = matcher
  end

  def dump
    dumpToFile('expected', @matcher.expected)
    dumpToFile('actual', @matcher.actual)
    dumpToFile('currentExpectedObj', @matcher.currentExpectedObj)
    dumpToFile('currentActualObj', @matcher.currentActualObj)
  end

  def dumpToFile(baseName, jsonHash)
    fileName = Dir.tmpdir() + File::SEPARATOR + "#{baseName}.json"
    File.open(fileName, "w") do |file|
      file.print JSON.pretty_generate(jsonHash)
    end
  end
end