require 'eq_json'
require 'json'
require 'spec_helper'

describe 'test nested array not same size' do
  it 'test not the same size' do

    actual = {
      bookSeller: "amazon",
      bookWholeSellers: {
        publisherInfo: {
          name: "ACME Publisher Inc.",
          publishDate: {
            month: 3,
            day: 23,
            year: 2015
          },
          products: {
            books: [
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
          }
        }
      },
      url: "www.amazon.com"
    }

    expected = {
      bookSeller: "amazon",
      bookWholeSellers: {
        publisherInfo: {
          name: "ACME Publisher Inc.",
          publishDate: {
            month: 3,
            day: 23,
            year: 2015
          },
          products: {
            books: [
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
          }
        }
      },
      url: "www.amazon.com"
    }

    customMatcher=EqualWithOutOrderJson.new(actual)

    expect(customMatcher.matches?(expected)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Expected: #{expectedJson}\n" +
                                  makeGreen("  Actual: #{actualJson}") + "\n" +
                                  "\nDiff:\n" +
                                  "JSON path $.bookWholeSellers.publisherInfo.products.books[] expected length 2 actual length 3\n"

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end
end
