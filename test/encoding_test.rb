# frozen_string_literal: true

require "test_helper"

class EncodingTest < Test::Unit::TestCase
  include Funcml

  test "encoding__base64encode_returns_encoded_string" do
    struct = {key: {_base64encode: "string"}}
    assert_equal struct.mutate[:key], "c3RyaW5n"

    struct = {key: {_base64encode: ""}}
    assert_equal struct.mutate[:key], ""
  end
end