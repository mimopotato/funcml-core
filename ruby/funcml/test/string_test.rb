# frozen_string_literal: true

require "test_helper"

class StringTest < Test::Unit::TestCase
  include Funcml

  test "string_get_mutated" do
    struct = {key: "$value"}
    mutations = {value: true}

    assert struct.mutate(mutations)[:key]
  end

  test "string_get_hash_recursively_mutated" do
    struct = {key: {subkey: "$value" }}
    mutations = {value: true}

    assert struct.mutate(mutations)[:key][:subkey]
  end

  test "string_get_string_recursively_mutated" do
    struct = {key: "$value"}
    mutations = {value: "$subvalue", subvalue: true}

    assert struct.mutate(mutations)[:key]
  end

  test "string_get_mutated_dig_path" do
    struct = {key: "$path.to.value"}
    mutations = {path: {to: {value: true}}}

    assert struct.mutate(mutations)[:key]
  end

  test "string_it_raise_exception_on_nil_value" do
    struct = {key: "$value"}
    mutations = {}

    assert_raise MutationException do
      struct.mutate(mutations)
    end
  end
end