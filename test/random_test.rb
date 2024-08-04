# froze_string_literal: true

require "test_helper"

class RandomTest < Test::Unit::TestCase
  include Funcml

  test "random__randomNumber" do
    struct = {key: {_randomNumber: nil}}
    result = struct.mutate
    assert result[:key] > 0
  end

  test "random__randomNumber_bounds" do
    100.times do
      struct = {key: {_randomNumber: {min: 1, max: 2}}}
      result = struct.mutate
      assert [1, 2].include?(result[:key])
    end
  end

  test "random__randomNumber_floats" do
    struct = {key: {_randomNumber: {min: 1.0, max: 2.0}}}
    assert_equal struct.mutate[:key].class, Float
  end

  test "random__randomString" do
    100.times do
      struct = {key: {_randomString: {length: 6}}}
      result = struct.mutate[:key]
      assert_equal result.length, 6
    end
  end

  test "random__randomString_whitelist" do
    100.times do
      struct = {key: {
        _randomString: {
          length: 6,
          allowed: "abc"
        }
      }}

      result = struct.mutate[:key]
      result.chars.each do |char|
        assert !"defhjklmnopqrstuvwxyz".chars.include?(char)
      end
    end
  end
end