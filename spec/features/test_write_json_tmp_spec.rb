require 'eq_json'
require 'json'
require 'spec_helper'

describe 'test debug files' do

  before(:each) do
    @tmpPath = Dir.tmpdir + File::SEPARATOR;

    @baseFileNames = %w(expected actual currentExpectedObj, currentActualObj)
    deleteDebugFiles()

    @actualBooks = [
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

    @actual = {
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
                    books: @actualBooks
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

    @expectedBooks = [
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

    @expected = {
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
                    books: @expectedBooks
                }
            }
        },
        url: "www.amazon.com"
    }

    @customMatcher=EqualWithOutOrderJson.new(@expected)

    expect(@customMatcher.matches?(@actual)).to eq(false)

    expectedJson=@expected.to_json;
    actualJson=@actual.to_json;

    @expectedErrorMessage= "Expected: #{expectedJson}\n" +
        makeGreen("  Actual: #{actualJson}") + "\n" +
        "\nDiff:\n" +
        "JSON path $.bookWholeSellers.publisherInfo.products.books[] could not find:\n" +
        "#{book3Item.to_json}\n" +
        "in actual\n"

  end

  after(:each) do
    RSpec.configure do |c|
      c.json_debug_config=false
    end
  end

  it 'test debug files generated when json_debug_config true' do

    RSpec.configuration.json_debug_config=true;

    expect(@customMatcher.failure_message).to eq(@expectedErrorMessage)

    assertJson("expected", @expected)
    assertJson("actual", @actual)
    assertJson("currentExpectedObj", @expectedBooks)
    assertJson("currentActualObj", @actualBooks)

    expect(@expected).not_to eq_json(@actual)

  end

  it 'test debug files not generated when json_debug_config false' do

    RSpec.configuration.json_debug_config=false;

    expect(@customMatcher.failure_message).to eq(@expectedErrorMessage)

    @baseFileNames.each() do |baseFileName|
      expect(File.exist?(@tmpPath + baseFileName + ".json")).to be false
    end

    expect(@expected).not_to eq_json(@actual)
  end
end

def assertJson(fileName, expectedHash)
  expectedFromFile = File.read @tmpPath + fileName + ".json"
  tempFileExpected = JSON.parse(expectedFromFile)

  expect(tempFileExpected).to eq(JSON.parse(JSON.pretty_generate(expectedHash)))
end

def deleteDebugFiles()

  @baseFileNames.each do |baseFileName|
    fileName = @tmpPath + baseFileName + ".json"
    File.delete(fileName) if File.exist?(fileName)
  end

end