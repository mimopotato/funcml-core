# frozen_string_literal: true

require "test_helper"

class CastTest < Test::Unit::TestCase
  include Funcml

  test "cast__string_parses_int_float_array_to_string" do
    struct = {_string: 1}
    assert_equal struct.mutate, "1"

    struct = {_string: 1.0}
    assert_equal struct.mutate, "1.0"

    struct = {_string: [1, 2, 3]}
    assert_equal struct.mutate, "[1, 2, 3]"
  end

  test "cast__int_parses_float_string_to_int" do
    struct = {_int: 1.0}
    assert_equal struct.mutate, 1

    struct = {_int: "1"}
    assert_equal struct.mutate, 1
  end

  test "cast__float_parses_int_string_to_float" do
    struct = {_float: 1}
    assert_equal struct.mutate, 1.0

    struct = {_float: "1.0"}
    assert_equal struct.mutate, 1.0
  end

  test "cast__json_parses_struct_to_string" do
    struct = {
      key: {
        _json: {
          test: "$value"
        }
      }
    }

    assert_equal struct.mutate({value: "abc"}), {key: '{"test":"abc"}'}
  end

  test "cast__fromJson_parses_string_to_struct" do
    struct = {
      _fromJson: '{"test": "abc"}'
    }

    assert_equal struct.mutate, {test: "abc"}
  end
end