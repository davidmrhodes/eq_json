require 'json'
require 'eq_json_array_with_key'
require 'spec_helper.rb'

describe 'test with nil values' do

  it 'test that objects with nil value equal' do
    actual = {
        name: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling',
        publisherInfo: {
            name: "ACME Publisher Inc.",
            publishDate: {
                month: 3,
                day: 23,
                year: nil
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
                year: nil
            }
        }
    }

    expect(expected).to eq_json(actual)
  end

end