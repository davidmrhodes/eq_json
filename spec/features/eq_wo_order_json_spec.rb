require 'eq_wo_order_json'
# require 'eq_wo_order'
require 'json'
require 'DaveTestSpec'
require 'foo'

# describe '#eq_wo_order_json' do
  # describe 'basic types' do
  #   describe 1 do
  #     it { is_expected.to eq_wo_order(1) }
  #     it { is_expected.not_to eq_wo_order(2) }
  #   end
  #
  #   describe 'a' do
  #     it { is_expected.to eq_wo_order('a') }
  #     it { is_expected.not_to eq_wo_order('b') }
  #   end
  #
  #   describe true do
  #     it { is_expected.to eq_wo_order(true) }
  #     it { is_expected.not_to eq_wo_order(false) }
  #   end
  # end
  #
  # describe 'arrays' do
  #   describe ['a', 'b'] do
  #     it { is_expected.to eq_wo_order(['a', 'b']) }
  #     it { is_expected.to eq_wo_order(['b', 'a']) }
  #     it { is_expected.not_to eq_wo_order(nil) }
  #   end
  #
  #   describe [1, 2] do
  #     it { is_expected.to eq_wo_order([1, 2]) }
  #     it { is_expected.to eq_wo_order([2, 1]) }
  #   end
  #
  #   describe [] do
  #     it { is_expected.to eq_wo_order([]) }
  #   end
  #
  #   describe 'of disparate types' do
  #     describe ['a', {b: 'c', d: 'e'}] do
  #       it { is_expected.to eq_wo_order([{d: 'e', b: 'c'}, 'a']) }
  #       it { is_expected.not_to eq_wo_order([5, {d: 'e', b: 'c'}, 'a']) }
  #     end
  #   end
  #
  #   describe 'of hashes' do
  #     describe [{a: 1}, {a: 2}] do
  #       it { is_expected.to eq_wo_order([{a: 2}, {a: 1}]) }
  #       it { is_expected.not_to eq_wo_order([{a: 1}]) }
  #       it { is_expected.not_to eq_wo_order([{a: 1}, {a: 2}, {a: 3}]) }
  #     end
  #
  #     describe [{a: 1, b: 1}, {a: 1, b: 2}] do
  #       it { is_expected.to eq_wo_order([{a: 1, b: 2}, {a: 1, b: 1}]) }
  #       it { is_expected.not_to eq_wo_order([{a: 1, b: 1}, {a: 1, b: 2, c: 3}]) }
  #     end
  #
  #     describe [{a: 1, b: 1}, {a: 1, b: 2, c: 3}] do
  #       it { is_expected.not_to eq_wo_order([{a: 1, b: 2}, {a: 1, b: 1}]) }
  #     end
  #
  #     describe 'of arrays' do
  #       describe [{a: [1, 2]}, {a: [3]}] do
  #         it { is_expected.to eq_wo_order([{a: [2, 1]}, {a: [3]}]) }
  #       end
  #     end
  #   end
  #
  #   describe 'of arrays' do
  #     describe [[1, 2]] do
  #       it { is_expected.to eq_wo_order([[2, 1]]) }
  #       it { is_expected.not_to eq_wo_order([[2, 1, 3]]) }
  #     end
  #
  #     describe [[1, 2], [3, 4]] do
  #       it { is_expected.to eq_wo_order([[1, 2], [3, 4]]) }
  #       it { is_expected.to eq_wo_order([[1, 2], [4, 3]]) }
  #       it { is_expected.to eq_wo_order([[2, 1], [4, 3]]) }
  #       it { is_expected.to eq_wo_order([[2, 1], [3, 4]]) }
  #       it { is_expected.to eq_wo_order([[3, 4], [1, 2]]) }
  #       it { is_expected.to eq_wo_order([[3, 4], [2, 1]]) }
  #       it { is_expected.to eq_wo_order([[4, 3], [2, 1]]) }
  #       it { is_expected.to eq_wo_order([[4, 3], [1, 2]]) }
  #       it { is_expected.not_to eq_wo_order([[1, 2]]) }
  #       it { is_expected.not_to eq_wo_order([[1, 2], [3, 4], [5, 6]]) }
  #     end
  #
  #     describe [[1, 2, 3]] do
  #       it { is_expected.to eq_wo_order([[2, 1, 3]]) }
  #       it { is_expected.not_to eq_wo_order([[2, 1]]) }
  #     end
  #
  #     describe [[[1, 2]]] do
  #       it { is_expected.to eq_wo_order([[[2, 1]]]) }
  #     end
  #   end
  # end
  #
  # describe 'hashes' do
  #   describe({a: 'b', c: 'd'}) do
  #     it { is_expected.to eq_wo_order({a: 'b', c: 'd'}) }
  #     it { is_expected.to eq_wo_order({c: 'd', a: 'b'}) }
  #     it { is_expected.not_to eq_wo_order({a: 'b', c: 'd', e: 'f'}) }
  #     it { is_expected.not_to eq_wo_order(nil) }
  #   end
  #
  #   describe({a: 1, b: 2}) do
  #     it { is_expected.to eq_wo_order({a: 1, b: 2}) }
  #     it { is_expected.to eq_wo_order({b: 2, a: 1}) }
  #   end
  #
  #   describe 'of arrays' do
  #     describe({a: [1, 2]}) do
  #       it { is_expected.to eq_wo_order({a: [2, 1]}) }
  #     end
  #
  #     describe 'of hashes' do
  #       describe({a: [{a: 5}, {b: 7}]}) do
  #         it { is_expected.to eq_wo_order({a: [{b: 7}, {a: 5}]}) }
  #       end
  #     end
  #   end
  #
  #   describe 'of hashes' do
  #     describe({a: {b: {c: 'd', e: 'f'}}}) do
  #       it { is_expected.to eq_wo_order({a: {b: {e: 'f', c: 'd'}}}) }
  #     end
  #
  #     describe 'of arrays' do
  #       describe({a: {b: [1, 2]}}) do
  #         it { is_expected.to eq_wo_order({a: {b: [2, 1]}}) }
  #       end
  #     end
  #   end
  # end

  fdescribe 'test json objects' do

    fit 'expected missing object in single level json' do

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

      # expectedErrorMessage= "actual does not contain author : \"J.K. Rowling\" \n Test"
      String expectedErrorMessage= "actual does not contain author: \"J.K. Rowling\"\n" +
                                   "Expected: #{expectedJson}"

      puts expectedErrorMessage

      String expectedDMR="Hello\n world"
      puts expectedDMR

      expect(customMatcher.failure_message).to eq(expectedErrorMessage)

      # expect(expected).to eq_wo_order_json(actual)
    end
  end

  # actual = {
  #   book:
  #     {
  #       name: 'Harry Potter and the Sorcerer\'s Stone',
  #       author: 'J.K. Rowling'
  #     }
  # }
  #
  # expected = {
  #     book:
  #       {
  #         name: 'Harry Potter and the Sorcerer\'s Stone',
  #         author: 'J.K. Rowling'
  #       }
  # }

    # describe 'test simple json mismatch' do
    #   temp=[{a: {b: 'test1', d: 'test2'}}]
    #
    #   tempJson = temp.to_json
    #   puts 'tempJson'
    #   pp tempJson
    #   puts JSON.parse(tempJson)
    #   jj JSON.parse(tempJson)
    #
    #
    #   it {
    #     # actual=[{a: {b: 'test1', d: 'test2'}}]
    #     actual=[{a: {b: 'test1'}}]
    #     expected=[{a: {b: 'test1', d: 'test2'}}]
    #
    #     # Foo.new
    #     # dave=DaveTestSpec.new("expected1")
    #     # test_dmr=dave.matches?("actual1")
    #
    #     # matcher_template = RSpec::Matchers::DSL::Matcher.new("eq_wo_order_json", &declarations)
    #
    #     expect(expected).to eq_wo_order_json(actual)
    #
    #     # is_expected.to eq_wo_order_json([{f: 5}, {a: [{d: 'e', b: 'c'}]}, {g: 'h'}])
    #   }
    # end
