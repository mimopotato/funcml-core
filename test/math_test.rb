# frozen_string_literal: true

require "test_helper"

class MathTest < Test::Unit::TestCase
  include Funcml

  test "math__add_mutates_calling_block" do
    struct = {_add: [1, 2]}
    assert_equal struct.mutate, 3

    struct = {_add: ["$first", "$second"]}
    assert_equal struct.mutate(first: 1, second: 2), 3
  end

  test "math__sub_mutates_calling_block" do
    struct = {_sub: [2, 1]}
    assert_equal struct.mutate, 1

    struct = {_sub: ["$first", "$second"]}
    assert_equal struct.mutate(first: 2, second: 1), 1
  end

  test "math__div_mutates_calling_block" do
    struct = {_div: [3.0, 2.0]}
    assert_equal struct.mutate, 1.5

    struct = {_div: ["$first", "$second"]}
    assert_equal struct.mutate(first: 3.0, second: 2.0), 1.5
  end
end