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

  test "math__mod_mutates_calling_block" do
    struct = {_mod: [2, 3]}
    assert_equal struct.mutate, 2

    struct = {_mod: ["$first", "$second"]}
    assert_equal struct.mutate(first: 2, second: 3), 2
  end

  test "math__mul_mutates_calling_block" do
    struct = {_mul: [2, 3]}
    assert_equal struct.mutate, 6

    struct = {_mul: ["$first", "$second"]}
    assert_equal struct.mutate(first: 2, second: 3), 6
  end

  test "math__min_mutates_calling_block" do
    struct = {_min: [1, 3, 4, 7, 2, 5]}
    assert_equal struct.mutate, 1

    struct = {_min: ["$first", 3, 4, 7, 2, 5]}
    assert_equal struct.mutate(first: 1), 1
  end

  test "math__max_mutates_calling_block" do
    struct = {_max: [1, 3, 4, 7, 2, 5]}
    assert_equal struct.mutate, 7

    struct = {_max: ["$first", 3, 4, 7, 2, 5]}
    assert_equal struct.mutate(first: 1), 7
  end

  test "math_floor_mutates_calling_block" do
    struct = {_floor: 1.1}
    assert_equal struct.mutate, 1

    struct = {_floor: "$floor"}
    assert_equal struct.mutate(floor: 1.1), 1
  end

  test "math_ceil_mutates_calling_block" do
    struct = {_ceil: 1.1}
    assert_equal struct.mutate, 2

    struct = {_ceil: "$ceil"}
    assert_equal struct.mutate(ceil: 1.1), 2
  end
end