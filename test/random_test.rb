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
    struct = {key: {_randomNumber: {min: 1, max: 2}}}
    10.times do
      result = struct.mutate
      assert result[:key] > 1 && result[:key] < 3
    end
  end
end