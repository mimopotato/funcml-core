# frozen_string_literal: true

require "test_helper"

class FilexTest < Test::Unit::TestCase
  include Funcml

  test "file__readfile_returns_file_content" do
    fakefile = File.open("./test.txt", "w+")
    fakefile.write("test")
    fakefile.close

    struct = {key: {_readfile: "./test.txt"}}
    assert_equal struct.mutate[:key], "test"

    File.delete("./test.txt")
  end
end