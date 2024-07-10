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

  test "crypto_sha1sum_from_mutation" do
    struct = {key: {_sha1sum: "$value"}}
    mutations = {value: "string"}

    assert_equal struct.mutate(mutations)[:key], "ecb252044b5ea0f679ee78ec1a12904739e2904d"
  end

  test "crypto__sha256sum_returns_computed_value" do
    struct = {key: {_sha256sum: "string"}}
    assert_equal struct.mutate[:key], "473287f8298dba7163a897908958f7c0eae733e25d2e027992ea2edc9bed2fa8"
  end

  test "crypto__sha256sum_null_value_returns_value" do
    struct = {key: {_sha256sum: ""}}
    assert_equal struct.mutate[:key], "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  end

  test "crypto_sha256sum_from_mutation" do
    struct = {key: {_sha256sum: "$value"}}
    mutations = {value: "string"}

    assert_equal struct.mutate(mutations)[:key], "473287f8298dba7163a897908958f7c0eae733e25d2e027992ea2edc9bed2fa8"
  end
end