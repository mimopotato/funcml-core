# frozen_string_literal: true

require "test_helper"

class TimeTest < Test::Unit::TestCase
  include Funcml

  test "time__now_returns_current_time" do
    struct = {key: {_time: {value: "$now"}}}
    assert_equal struct.mutate[:key], Time.now.strftime("%d/%m/%Y %H:%M:%S").to_s
  end

  test "time__time_gets_parsed" do
    time = Time.now.strftime("%d/%m/%Y %H:%M:%S").to_s
    struct = {key: {_time: {value: time}}}
    assert_equal struct.mutate[:key], time
  end
end