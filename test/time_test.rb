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

  test "time__ago_returns_time_minus_x" do
    struct = {key: {_time: {value: {_ago: 600}}}}
    assert_equal struct.mutate[:key], (Time.now - 600).strftime("%d/%m/%Y %H:%M:%S").to_s
  end

  test "time__ago_raise_error_when_not_seconds" do
    struct = {key: {_time: {value: {_ago: :test}}}}
    assert_raise IncorrectSecondsException do
      struct.mutate
    end
  end
end