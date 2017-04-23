require 'eq_json'
require 'json'
require 'spec_helper'

describe 'test nested array not same' do
  
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

  it 'test not the same object type' do

    actualBooks = [
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
            books: actualBooks
          }
        }
      },
      url: "www.amazon.com"
    }

    expectedBooks = {
        book1: {
          bookId: "1",
          name: "Harry Potter and the Sorcerer's Stone",
          author: "J.K. Rowling"
        },
        book2: {
          bookId: "2",
          name: "Eragon",
          author: "Christopher Paolini"
        }
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
             books: expectedBooks
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
                                  "Diff:\n" +
                                  "JSON path $.bookWholeSellers.publisherInfo.products.books expected object type but actual is array\n" +
                                  "\tExpected: #{expectedBooks.to_json}\n" +
                                  makeGreen("\t  Actual: #{actualBooks.to_json}") + "\n"

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end

end

describe 'test nested array' do

  it 'test actual and expected equal' do

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

    expect(expected).to eq_json(actual)
  end

  it 'test actual and expected equal but out of order' do

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
                bookId: "3",
                name: "The Fellowship of the Ring",
                author: "J.R.R. Tolkien"
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

    expect(expected).to eq_json(actual)
  end

  it 'test actual does not contain an element in expected' do

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

    customMatcher=EqualWithOutOrderJson.new(actual)

    expect(customMatcher.matches?(expected)).to eq(false)

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

  it 'test expected has two of same elements and actual has one' do

    book3Item =
    {
      bookId: "3",
      name: "The Fellowship of the Ring",
      author: "J.R.R. Tolkien"
    }

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
              },
              book3Item
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
              book3Item,
              book3Item,
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
                                  "JSON path $.bookWholeSellers.publisherInfo.products.books[] wrong number of:\n" +
                                  "#{book3Item.to_json}\n" +
                                  "in actual\n" +
                                  "expected: 2\n" +
                                  makeGreen("     got: 1") + "\n"

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end

  it 'test expected has two of same elements and actual has three' do

    book3Item =
    {
      bookId: "3",
      name: "The Fellowship of the Ring",
      author: "J.R.R. Tolkien"
    }

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
                bookId: "4",
                name: "Effective Java",
                author: "Cannot Remember"
              },
              book3Item,
              book3Item,
              book3Item
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
              book3Item,
              {
                bookId: "1",
                name: "Harry Potter and the Sorcerer's Stone",
                author: "J.K. Rowling"
              },
              book3Item,
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
                                  "JSON path $.bookWholeSellers.publisherInfo.products.books[] wrong number of:\n" +
                                  "#{book3Item.to_json}\n" +
                                  "in actual\n" +
                                  "expected: 2\n" +
                                  makeGreen("     got: 3") + "\n"

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(expected).not_to eq_json(actual)
  end

end
