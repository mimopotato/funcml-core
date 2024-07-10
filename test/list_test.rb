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
end