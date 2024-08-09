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

  test "string__uuidv4_returns_new_uuid" do
    struct = {key: "$uuidv4"}
    assert_equal struct.mutate[:key].class, String
    assert_equal struct.mutate[:key].length, 36
  end

  test "string__env_returns_env_variable" do
    struct = {key: {_env: "TEST"}}
    ENV["TEST"] = "true"

    assert_equal struct.mutate, {key: "true"}
  end

  test "string__strictEnv_raise_when_missing" do
    struct = {key: {_strictEnv: "TEST" }}
    ENV["TEST"] = nil
    assert_raise MissingEnvVariableStrictException do
      struct.mutate
    end
  end

  test "string__env_is_upcased" do
    struct = {key: {_env: "test"}}
    ENV["TEST"] = "test"
    assert_equal struct.mutate, {key: "test"}
  end
end