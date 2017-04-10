require 'eq_wo_order_json'
require 'json'



describe 'test objects not same type' do
  it 'expected JSON array actual JSON object' do
    actual = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling'
    }

    expected = [
      { name: 'Harry Potter and the Sorcerer\'s Stone'},
      { author: 'J.K. Rowling'}
    ]

    expectedJson=expected.to_json

    actualJson=actual.to_json

    customMatcher=EqualWithOutOrderJson.new(actual)

    expect(customMatcher.matches?(expected)).to eq(false)

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                 makeGreen("Actual: #{actualJson}") + "\n"
                                 "Diff:\n"
                                 "JSON path [ expected array type but actual is object\n" +
                                 "@@ -1,4 +1,2 @@\n"
                                 "-:author => \"J.K. Rowling\","
                                 "-:isbn => 439708184,"
                                 ":name => \"Harry Potter and the Sorcerer's Stone\","

    # expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_wo_order_json(actual)
  end

  # TODO test with nested object and array missmatch
end

describe 'test single level json objects' do

    it 'test that objects equal in order' do
      actual = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling'
      }

      expected = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling'
      }

      expect(expected).to eq_wo_order_json(actual)
    end

    it 'test that objects equal out of order' do
      actual = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling'
      }

      expected = {
        author: 'J.K. Rowling',
        name: 'Harry Potter and the Sorcerer\'s Stone'
      }

      expect(expected).to eq_wo_order_json(actual)
    end

    it 'actual missing object' do

      actual = {
        name: 'Harry Potter and the Sorcerer\'s Stone'
      }

      expected = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling'
      }

      customMatcher=EqualWithOutOrderJson.new(actual)

      expect(customMatcher.matches?(expected)).to eq(false)

      expectedJson=expected.to_json;
      actualJson=actual.to_json;

      String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                    makeGreen("Actual: #{actualJson}") + "\n" +
                                    "Diff:\n" +
                                    "JSON path { actual does not contain {\"author\":\"J.K. Rowling\"}\n" +
                                    wrapWithResetColor("\n") + makeBlue("@@ -1,2 +1,3 @@\n") +
                                    makeGreen("+:author => \"J.K. Rowling\",\n") +
                                    wrapWithResetColor(" :name => \"Harry Potter and the Sorcerer's Stone\",\n")

      expect(customMatcher.failure_message).to eq(expectedErrorMessage)

      expect(expected).not_to eq_wo_order_json(actual)
    end

    it 'expected missing object' do

      actual = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling'
      }

      expected = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
      }

      customMatcher=EqualWithOutOrderJson.new(actual)

      expect(customMatcher.matches?(expected)).to eq(false)

      expectedJson=expected.to_json;
      actualJson=actual.to_json;

      String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                    makeGreen("Actual: #{actualJson}") + "\n" +
                                    "Diff:\n" +
                                    "JSON path { expected does not contain {\"author\":\"J.K. Rowling\"}\n" +
                                    wrapWithResetColor("\n") + makeBlue("@@ -1,3 +1,2 @@\n") +
                                    makeRed("-:author => \"J.K. Rowling\",\n") +
                                    wrapWithResetColor(" :name => \"Harry Potter and the Sorcerer's Stone\",\n")

      expect(customMatcher.failure_message).to eq(expectedErrorMessage)

      expect(expected).not_to eq_wo_order_json(actual)
    end

    it 'expected missing mutiple objects' do

      actual = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling',
        isbn: 439708184
      }

      expected = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
      }

      customMatcher=EqualWithOutOrderJson.new(actual)

      expect(customMatcher.matches?(expected)).to eq(false)

      expectedJson=expected.to_json;
      actualJson=actual.to_json;

      String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                    makeGreen("Actual: #{actualJson}") + "\n" +
                                    "Diff:\n" +
                                    "JSON path { expected does not contain {\"author\":\"J.K. Rowling\",\"isbn\":439708184}\n" +
                                    wrapWithResetColor("\n") + makeBlue("@@ -1,4 +1,2 @@\n") +
                                    makeRed("-:author => \"J.K. Rowling\",\n") +
                                    makeRed("-:isbn => 439708184,\n") +
                                    wrapWithResetColor(" :name => \"Harry Potter and the Sorcerer's Stone\",\n")

      expect(customMatcher.failure_message).to eq(expectedErrorMessage)

      expect(expected).not_to eq_wo_order_json(actual)
    end

  end

  def makeGreen(text)
    return colorize(text, 32);
    # return "\e[32m#{text}\e[0m"
  end

  def makeRed(text)
    colorize(text, 31)
  end

  def makeBlue(text)
    colorize(text, 34)
  end

  def colorize(text, color_code)
      "\e[#{color_code}m#{text}\e[0m"
  end

  def wrapWithResetColor(text)
    "\e[0m#{text}\e[0m"
  end