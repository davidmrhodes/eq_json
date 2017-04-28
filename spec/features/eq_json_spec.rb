require 'eq_json'
require 'json'
require 'spec_helper'

describe 'test objects not same type' do
  it 'expected JSON array actual JSON object' do
    actual = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling'
    }

    expected = [
        {name: 'Harry Potter and the Sorcerer\'s Stone'},
        {author: 'J.K. Rowling'}
    ]

    expectedJson=expected.to_json

    actualJson=actual.to_json

    customMatcher=EqualWithOutOrderJson.new(expected)

    expect(customMatcher.matches?(actual)).to eq(false)

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
        makeGreen("  Actual: #{actualJson}") + "\n" +
        "Diff:\n" +
        "JSON path $. expected array type but actual is object\n"

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(actual).not_to eq_json(expected)
  end

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

    expect(actual).to eq_json(expected)
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

    expect(actual).to eq_json(expected)
  end

  it 'actual missing object' do

    actual = {
        name: 'Harry Potter and the Sorcerer\'s Stone'
    }

    expected = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling'
    }

    customMatcher=EqualWithOutOrderJson.new(expected)

    expect(customMatcher.matches?(actual)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
        makeGreen("  Actual: #{actualJson}") + "\n" +
        "\nDiff:\n" +
        "JSON path $.\n" +
        makeGreen("actual does not contain {\"author\":\"J.K. Rowling\"}\n") +
        wrapWithResetColor("\n") + makeBlue("@@ -1,2 +1,3 @@\n") +
        makeGreen("+:author => \"J.K. Rowling\",\n") +
        wrapWithResetColor(" :name => \"Harry Potter and the Sorcerer's Stone\",\n")

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(actual).not_to eq_json(expected)
  end

  it 'expected missing object' do

    actual = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling'
    }

    expected = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
    }

    customMatcher=EqualWithOutOrderJson.new(expected)

    expect(customMatcher.matches?(actual)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
        makeGreen("  Actual: #{actualJson}") + "\n" +
        "\nDiff:\n" +
        "JSON path $.\n" +
        "expected does not contain {\"author\":\"J.K. Rowling\"}\n" +
        wrapWithResetColor("\n") + makeBlue("@@ -1,3 +1,2 @@\n") +
        makeRed("-:author => \"J.K. Rowling\",\n") +
        wrapWithResetColor(" :name => \"Harry Potter and the Sorcerer's Stone\",\n")

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(actual).not_to eq_json(expected)
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

    customMatcher=EqualWithOutOrderJson.new(expected)

    expect(customMatcher.matches?(actual)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
        makeGreen("  Actual: #{actualJson}") + "\n" +
        "\nDiff:\n" +
        "JSON path $.\n" +
        "expected does not contain {\"author\":\"J.K. Rowling\",\"isbn\":439708184}\n" +
        wrapWithResetColor("\n") + makeBlue("@@ -1,4 +1,2 @@\n") +
        makeRed("-:author => \"J.K. Rowling\",\n") +
        makeRed("-:isbn => 439708184,\n") +
        wrapWithResetColor(" :name => \"Harry Potter and the Sorcerer's Stone\",\n")

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(actual).not_to eq_json(expected)
  end

  it 'expected and actual both have missing objects' do

    actual = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling'
    }

    expected = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        publisher: 'ACME Publisher Inc.'
    }


    customMatcher=EqualWithOutOrderJson.new(expected)

    expect(customMatcher.matches?(actual)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
        makeGreen("  Actual: #{actualJson}") + "\n" +
        "\nDiff:\n" +
        "JSON path $.\n" +
        "expected does not contain {\"author\":\"J.K. Rowling\"}\n" +
        makeGreen("actual does not contain {\"publisher\":\"ACME Publisher Inc.\"}\n") + wrapWithResetColor("\n") +
        wrapWithResetColor("\n") + makeBlue("@@ -1,3 +1,3 @@\n") +
        makeRed("-:author => \"J.K. Rowling\",\n") +
        wrapWithResetColor(" :name => \"Harry Potter and the Sorcerer's Stone\",\n") +
        makeGreen("+:publisher => \"ACME Publisher Inc.\",\n")

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(actual).not_to eq_json(expected)
  end

  it 'expected and actual have different values for key' do

    actual = {
        name: 'Harry Potter and the Chamber of Secrets',
        author: 'J.K. Rowling'
    }

    expected = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling'
    }

    customMatcher=EqualWithOutOrderJson.new(expected)

    expect(customMatcher.matches?(actual)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
        makeGreen("  Actual: #{actualJson}") + "\n" +
        "Diff:\n" +
        "JSON path $.name\n" +
        "\texpected: \"Harry Potter and the Sorcerer\'s Stone\"\n" +
        makeGreen("\t     got: \"Harry Potter and the Chamber of Secrets\"")

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(actual).not_to eq_json(expected)
  end
end
