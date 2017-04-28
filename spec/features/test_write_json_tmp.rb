require 'eq_json'
require 'json'
require 'spec_helper'

xit 'test actual does not contain an element in expected' do

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
                          bookId: "4",
                          name: "Effective Java",
                          author: "Cannot Remember"
                      }
                  ]
              }
          }
      },
      url: "www.amazon.com"
  }

  book3Item =
      {
          bookId: "3",
          name: "The Fellowship of the Ring",
          author: "J.R.R. Tolkien"
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
                      },
                      book3Item
                  ]
              }
          }
      },
      url: "www.amazon.com"
  }

  customMatcher=EqualWithOutOrderJson.new(expected)

  expect(customMatcher.matches?(actual)).to eq(false)

  expectedJson=expected.to_json;
  actualJson=actual.to_json;

  String expectedErrorMessage= "Expected: #{expectedJson}\n" +
      makeGreen("  Actual: #{actualJson}") + "\n" +
      "\nDiff:\n" +
      "JSON path $.bookWholeSellers.publisherInfo.products.books[] could not find:\n" +
      "#{book3Item.to_json}\n" +
      "in actual\n"

  expect(customMatcher.failure_message).to eq(expectedErrorMessage)

  expect(expected).not_to eq_json(actual)
end