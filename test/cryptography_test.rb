# frozen_string_literal: true

require "test_helper"

class CryptographyTest < Test::Unit::TestCase
  include Funcml

  test "crypto__sha1sum_returns_computed_value" do
    struct = {key: {_sha1sum: "string"}}
    assert_equal struct.mutate[:key], "ecb252044b5ea0f679ee78ec1a12904739e2904d"
  end

  test "crypto__sha1sum_null_value_returns_value" do
    struct = {key: {_sha1sum: ""}}
    assert_equal struct.mutate[:key], "da39a3ee5e6b4b0d3255bfef95601890afd80709"
  end
end