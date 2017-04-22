require 'eq_json'
require 'json'

describe 'test nested objects not same type' do
  it 'expected JSON array actual JSON object' do

    actual = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          month: 3,
          day: 23,
          year: 2015
        }
      }
    }

    expected = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: [
          {
            month: 2,
            day: 24,
            year: 2011
          },
          {
            month: 1,
            day: 2,
            year: 1999
          }
        ]
      }
    }

    expectedJson=expected.to_json

    actualJson=actual.to_json

    customMatcher=EqualWithOutOrderJson.new(actual)

    expect(customMatcher.matches?(expected)).to eq(false)

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                 makeGreen("  Actual: #{actualJson}") + "\n" +
                                 "Diff:\n" +
                                 "JSON path $.publisherInfo.publishDate expected array type but actual is object\n" +
                                 "\tExpected: [" +
                                                "{\"month\":2,\"day\":24,\"year\":2011}," +
                                                "{\"month\":1,\"day\":2,\"year\":1999}" +
                                             "]\n" +
                                makeGreen("\tActual: {\"month\":3,\"day\":23,\"year\":2015}") + "\n"

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end
end

describe 'test nested level json objects' do

  it 'test that objects equal in order' do
      actual = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling',
        publisherInfo: {
          name: "ACME Publisher Inc.",
          publishDate: {
            month: 3,
            day: 23,
            year: 2015
          }
        }
      }

      expected = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling',
        publisherInfo: {
          name: "ACME Publisher Inc.",
          publishDate: {
            month: 3,
            day: 23,
            year: 2015
          }
        }
      }

    expect(expected).to eq_json(actual)
  end

  it 'test that objects equal out of order' do

    actual = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      publisherInfo: {
        publishDate: {
          year: 2015,
          month: 3,
          day: 23
        },
        name: "ACME Publisher Inc."
      },
      author: 'J.K. Rowling'
    }

    expected = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          month: 3,
          day: 23,
          year: 2015
        }
      }
    }

    expect(expected).to eq_json(actual)
  end

  it 'actual missing object' do

    actual = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          month: 3,
          year: 2015
        }
      }
    }

    expected = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          month: 3,
          day: 23,
          year: 2015
        }
      }
    }

    customMatcher=EqualWithOutOrderJson.new(actual)

    expect(customMatcher.matches?(expected)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                  makeGreen("  Actual: #{actualJson}") + "\n" +
                                  "\nDiff:\n" +
                                  "JSON path $.publisherInfo.publishDate\n" +
                                  makeGreen("actual does not contain {\"day\":23}\n") +
                                  wrapWithResetColor("\n") + makeBlue("@@ -1,3 +1,4 @@\n") +
                                  makeGreen("+:day => 23,\n") +
                                  wrapWithResetColor(" :month => 3,\n") +
                                  wrapWithResetColor(" :year => 2015,\n")

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end

  it 'expected missing object' do

    actual = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          month: 3,
          day: 23,
          year: 2015
        }
      }
    }

    expected = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          month: 3,
          day: 23,
        }
      }
    }

    customMatcher=EqualWithOutOrderJson.new(actual)

    expect(customMatcher.matches?(expected)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                  makeGreen("  Actual: #{actualJson}") + "\n" +
                                  "\nDiff:\n" +
                                  "JSON path $.publisherInfo.publishDate\n" +
                                  "expected does not contain {\"year\":2015}\n" +
                                  wrapWithResetColor("\n") + makeBlue("@@ -1,4 +1,3 @@\n") +
                                  wrapWithResetColor(" :day => 23,\n") +
                                  wrapWithResetColor(" :month => 3,\n") +
                                  makeRed("-:year => 2015,\n")

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end

  it 'expected missing mutiple objects' do

    actual = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          month: 3,
          day: 23,
          year: 2015
        }
      }
    }

    expected = {
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          month: 3
        }
      },
      author: 'J.K. Rowling',
      name: 'Harry Potter and the Sorcerer\'s Stone'
    }

    customMatcher=EqualWithOutOrderJson.new(actual)

    expect(customMatcher.matches?(expected)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                  makeGreen("  Actual: #{actualJson}") + "\n" +
                                  "\nDiff:\n" +
                                  "JSON path $.publisherInfo.publishDate\n" +
                                  "expected does not contain {\"day\":23,\"year\":2015}\n" +
                                  wrapWithResetColor("\n") + wrapWithResetColor("\n") +
                                  makeBlue("@@ -1,4 +1,2 @@\n") +
                                  makeRed("-:day => 23,\n") +
                                  wrapWithResetColor(" :month => 3,\n") +
                                  makeRed("-:year => 2015,\n")

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end


  it 'expected and actual both have missing objects' do

    actual = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          day: 23,
          year: 2015
        }
      }
    }

    expected = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          month: 3,
          day: 23
        }
      }
    }

    customMatcher=EqualWithOutOrderJson.new(actual)

    expect(customMatcher.matches?(expected)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                  makeGreen("  Actual: #{actualJson}") + "\n" +
                                  "\nDiff:\n" +
                                  "JSON path $.publisherInfo.publishDate\n" +
                                  "expected does not contain {\"year\":2015}\n" +
                                  makeGreen("actual does not contain {\"month\":3}\n") +
                                  wrapWithResetColor("\n") + makeBlue("@@ -1,3 +1,3 @@\n") +
                                  wrapWithResetColor(" :day => 23,\n") +
                                  makeRed("-:year => 2015,\n") +
                                  makeGreen("+:month => 3,\n")

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end

  it 'expected and actual have different values for key' do

    actual = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          month: 3,
          day: 23,
          year: 2017
        }
      }
    }

    expected = {
      name: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      publisherInfo: {
        name: "ACME Publisher Inc.",
        publishDate: {
          month: 3,
          day: 23,
          year: 2015
        }
      }
    }

    customMatcher=EqualWithOutOrderJson.new(actual)

    expect(customMatcher.matches?(expected)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                  makeGreen("  Actual: #{actualJson}") + "\n" +
                                  "Diff:\n" +
                                  "JSON path $.publisherInfo.publishDate.year\n" +
                                  "\texpected: \"2015\"\n" +
                                  makeGreen("\t     got: \"2017\"")

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end

end
