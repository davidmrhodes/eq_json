require 'json'
require 'eq_json_array_with_key'
require 'spec_helper.rb'

describe 'test arrays not the same size' do

  it 'actual contains more items than expected' do

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
                            author: "Christopher Paolini",
                        },
                        {
                            bookId: "4",
                            name: "Effective Java",
                            authoer: "Cannot Remember"
                        },
                        {
                            bookId: "5",
                            name: "The HP Way",
                            authoer: "Bill and Dave"
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
    actualArray = actual[:bookWholeSellers][:publisherInfo][:products][:books]

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
                            bookId: "3",
                            name: "The Fellowship of the Ring",
                            author: "J.R.R. Tolkien"

                        },
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

    expectedArray = expected[:bookWholeSellers][:publisherInfo][:products][:books]


    customMatcher=EqualJsonArrayWithKey.new(expectedArray, :bookId)

    expect(customMatcher.matches?(actualArray)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Array size does not match. Expected 3 actual 5\n" +
        "expected does not contain bookIds [\"4\", \"5\"]\n"

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(actualArray).not_to eq_json_array_with_key(expectedArray, :bookId)

  end

  it 'expected contains more items than actual' do

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
                            author: "Christopher Paolini",
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
    actualArray = actual[:bookWholeSellers][:publisherInfo][:products][:books]

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
                            bookId: "3",
                            name: "The Fellowship of the Ring",
                            author: "J.R.R. Tolkien"

                        },
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
                            bookId: "5",
                            name: "The HP Way",
                            authoer: "Bill and Dave"
                        }
                    ]
                }
            }
        },
        url: "www.amazon.com"
    }

    expectedArray = expected[:bookWholeSellers][:publisherInfo][:products][:books]


    customMatcher=EqualJsonArrayWithKey.new(expectedArray, :bookId)

    expect(customMatcher.matches?(actualArray)).to eq(false)

    expectedJson=expected.to_json;
    actualJson=actual.to_json;

    String expectedErrorMessage= "Array size does not match. Expected 4 actual 3\n" +
        "actual does not contain bookIds [\"5\"]\n"

    expect(customMatcher.failure_message).to eq(expectedErrorMessage)

    expect(actualArray).not_to eq_json_array_with_key(expectedArray, :bookId)

  end

end
