# frozen_string_literal: true

require "test_helper"

class ListTest < Test::Unit::TestCase
  include Funcml

  test "list__first_returns_first_element" do
    struct = {key: {_first: [1, 2, 3]}}
    assert_equal struct.mutate, {key: 1}
  end

  test "list__tail_returns_n_elements" do
    struct = {key: {_tail: [[1, 2, 3], 2]}}
    assert_equal struct.mutate, {key: [2, 3]}
  end

  test "list__head_returns_n_elements" do
    struct = {key: {_head: [[1, 2, 3], 2]}}
    assert_equal struct.mutate, {key: [1, 2]}
  end

  test "list__reverse_returns_reversed_elements" do
    struct = {key: {_reverse: [1, 2, 3]}}
    assert_equal struct.mutate, {key: [3, 2, 1]}
  end

  test "list__uniq_returns_uniq_values" do
    struct = {key: {_uniq: [1, 2, 3, 1, 2, 3]}}
    assert_equal struct.mutate, {key: [1, 2, 3]}
  end

  test "list__index_returns_index_for_value" do
    struct = {key: {_index: [["test", "test-2", "test-3"], "test-3"]}}
    assert_equal struct.mutate, {key: 2}
  end
end