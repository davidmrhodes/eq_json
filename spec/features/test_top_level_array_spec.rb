require 'eq_wo_order_json'
require 'json'
require 'spec_helper'

describe 'test top level array' do
  it 'test not the same size' do

    actual = [
        {
          bookId: "1",
          name: "Harry Potter and the Sorcerer's Stone",
          author: "J.K. Rowling"
        },
        {
          bookId: "2",
          name: "Eragon",
          author: "Christopher Paolini"
        },
        {
          bookId: "3",
          name: "The Fellowship of the Ring",
          author: "J.R.R. Tolkien"
        }
    ]

    expected = [
        {
          bookId: "1",
          name: "Harry Potter and the Sorcerer's Stone",
          author: "J.K. Rowling"
        },
        {
          bookId: "2",
          name: "Eragon",
          author: "Christopher Paolini"
        }
    ]

    customMatcher=EqualWithOutOrderJson.new(actual)

    expect(customMatcher.matches?(expected)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                  makeGreen("  Actual: #{actualJson}") + "\n" +
                                  "\nDiff:\n" +
                                  "JSON path $.[] expected length 2 actual length 3\n"

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end

  it 'test actual does not contain an element in expected' do

    actual = [
        {
          bookId: "1",
          name: "Harry Potter and the Sorcerer's Stone",
          author: "J.K. Rowling"
        },
        {
          bookId: "2",
          name: "Eragon",
          author: "Christopher Paolini"
        },
        {
          bookId: "4",
          name: "Effective Java",
          author: "Cannot Remember"
        }
    ]

    book3Item =
    {
      bookId: "3",
      name: "The Fellowship of the Ring",
      author: "J.R.R. Tolkien"
    }

    expected = [
        {
          bookId: "1",
          name: "Harry Potter and the Sorcerer's Stone",
          author: "J.K. Rowling"
        },
        {
          bookId: "2",
          name: "Eragon",
          author: "Christopher Paolini"
        },
        book3Item
    ]

    customMatcher=EqualWithOutOrderJson.new(actual)

    expect(customMatcher.matches?(expected)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                  makeGreen("  Actual: #{actualJson}") + "\n" +
                                  "\nDiff:\n" +
                                  "JSON path $.[] could not find:\n" +
                                  "#{book3Item.to_json}\n" +
                                  "in actual\n"

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end
end
