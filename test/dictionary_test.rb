# frozen_string_literal: true

require "test_helper"

class DictionaryTest < Test::Unit::TestCase
  include Funcml

  test "hash__keys_returns_array_elements" do
    struct = {key: {_keys: [1, 2, 3]}}
    assert_equal struct.mutate, {key: [1, 2, 3]}
  end

  test "hash__keys_returns_hash_keys" do
    struct = {key: {_keys: [{key: :value}, {foo: :bar}]}}
    assert_equal struct.mutate, {key: [:key, :foo]}
  end

  test "hash__values_returns_array_elements" do
    struct = {key: {_values: [1, 2, 3]}}
    assert_equal struct.mutate, {key: [1, 2, 3]}
  end

  test "hash__values_returns_hash_values" do
    struct = {key: {_values: [{key: :value}, {foo: :bar}]}}
    assert_equal struct.mutate, {key: [:value, :bar]}
  end

  test "hash__first_returns_first_element" do
    struct = {key: {_first: [1, 2, 3]}}
    assert_equal struct.mutate, {key: 1}
  end

  test "hash__tail_returns_n_elements" do
    struct = {key: {_tail: [[1, 2, 3], 2]}}
    assert_equal struct.mutate, {key: [2, 3]}
  end

  test "hash__head_returns_n_elements" do
    struct = {key: {_head: [[1, 2, 3], 2]}}
    assert_equal struct.mutate, {key: [1, 2]}
  end
end