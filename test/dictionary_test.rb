# frozen_string_literal: true

require "test_helper"

class DictionaryTest < Test::Unit::TestCase
  include Funcml

  test "hash__keys_returns_hash_keys" do
    struct = {key: {_keys: "$allkeys"}}
    mutations = {allkeys: [{key: :value}, {foo: :bar}]}

    assert_equal struct.mutate(mutations), {key: [:key, :foo]} 
  end

  test "hash__keys_raise_when_not_array_of_hash" do
    struct = {key: {_keys: "$allkeys"}}
    mutations = {allkeys: {key: :value, foo: :bar}}

    assert_equal struct.mutate(mutations)[:key], [:key, :foo]
  end
end