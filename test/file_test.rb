# frozen_string_literal: true

require "test_helper"
require "tempfile"

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

  test "file__import_returns_struct" do
    struct1 = {key: "value"}
    tmpfile = Tempfile.create('struct1')
    tmpfile.write(struct1.to_json)
    tmpfile.close

    struct2 = {data: {_import: tmpfile.path }}
    result = struct2.mutate
    assert_equal result, {data: {key: "value"}}
    puts result
  end
end