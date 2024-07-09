# frozen_string_literal: true

require "test_helper"

class FuncmlTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::Funcml.const_defined?(:VERSION)
    end
  end
end
