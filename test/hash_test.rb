# frozen_string_literal: true

require "test_helper"

class HashTest < Test::Unit::TestCase
  include Funcml

  test "hash_it_return_itself" do
    struct = {key: true}
    assert struct.mutate[:key]
  end

  test "hash__merge_adds_hash_to_hash" do
    struct = {key: "value", _merge: "$merge"}
    mutations = {merge: {merged: true}}

    assert_equal struct.mutate(mutations)[:key], "value"
    assert struct.mutate(mutations)[:merged]
    assert_nil struct.mutate(mutations)[:_merge]
  end

  test "hash__merge_elements_recursive_mutations" do
    struct = {key: {_merge: "$merge"}}
    mutations = {merge: "$value", value: {works: true}}

    assert struct.mutate(mutations)[:key][:works]
    assert_equal struct.mutate(mutations), {key: {works: true}}
  end

  test "hash__concat_concats_elem_to_hash" do
    struct = {key: {_concat: {items: ["a", "b", "c"]}}}
    assert_equal struct.mutate[:key], "abc"
    assert_equal struct.mutate, {key: "abc"}
  end

  test "hash__concat_with_separator" do
    struct = {key: {_concat: {items: ["a", "b", "c"], sep: " "}}}
    assert_equal struct.mutate[:key], "a b c"
    assert_equal struct, {key: "a b c"}
  end

  test "hash__sum_sums_values" do
    struct = {key: {_sum: [1, 2, 3]}}
    target = {key: 6}
    assert_equal struct.mutate, target
  end

  test "hash__loop_generates_blocks_from_array" do
    struct = {key: {_loop: {
      items: ["a", "b", "c"],
      block: {
        value: "$item"
      }
    }}}
    
    assert_equal struct.mutate, {key: [{value: "a"}, {value: "b"}, {value: "c"}]}
  end

  test "hash__loop_generate_blocks_from_arr_of_hashes" do
    struct = { key: {_loop: {
        items: [{value: "a"}, {value: "b"}, {value: "c"}],
        block: { value: "$item.value" }
      }}}

    assert_equal struct.mutate, {key: [{value: "a"}, {value: "b"}, {value: "c"}]}
  end

  test "hash__loop_raise_error_on_unsupported_types" do
    assert_raise LoopTypeException do
      {key: {_loop: {items: "a", block: {nil: true}}}}.mutate
    end
  end

  test "hash__loop_works_with_mutated_values" do
    struct = {
      key: {
        _loop: {
          items: ["$val1", "$val2"],
          block: {
            value: "$item.zalue"
          }
        }
      }
    }

    mutations = {
      val1: { zalue: true},
      val2: { zalue: false}
    }

    assert_equal struct.mutate(mutations), {key: [{value: true}, {value: false}]}
  end

  test "hash__if_in" do
    struct = {_if: [{in: ["a", ["a", "b", "c"]]}], value: true}
    assert_equal struct.mutate, {value: true}

    struct = {_if: [{in: ["a", ["x", "y", "z"]]}], value: true}
    assert_equal struct.mutate, nil
  end

  test "hash__if_raise_exception_not_exist" do
    struct = {_if: [{notexist: []}]}
    assert_raise UnknownConditionException do
      struct.mutate
    end
  end

  test "hash__if_null" do
    struct = {_if: [{null: [nil]}], value: true}
    assert_equal struct.mutate, {value: true}

    struct = {_if: [{null: [:set]}], value: true}
    assert_equal struct.mutate, nil
  end

  test "hash__if_present" do
    struct = {_if: [{present: [:set]}], value: true}
    assert_equal struct.mutate, {value: true}

    struct = {_if: [{present: [nil]}], value: true}
    assert_equal struct.mutate, nil
  end

  test "hash__if_eq" do
    assert_equal ({_if: [{eq: [1, 2]}], value: true}.mutate), nil
    assert_equal ({_if: [{eq: [1, 1]}], value: true}.mutate), {value: true}
  end

  test "hash__if_ne" do
    assert_equal ({_if: [{ne: [1, 2]}], value: true}.mutate), {value: true}
    assert_equal ({_if: [{ne: [1, 1]}], value: true}.mutate), nil
  end

  test "hash__if_gt" do
    assert_equal ({_if: [{gt: [1, 2]}], value: true}.mutate), nil
    assert_equal ({_if: [{gt: [1, 1]}], value: true}.mutate), nil
    assert_equal ({_if: [{gt: [2, 1]}], value: true}.mutate), {value: true}
  end

  test "hash__if_lt" do
    assert_equal ({_if: [{lt: [1, 2]}], value: true}.mutate), {value: true}
    assert_equal ({_if: [{lt: [1, 1]}], value: true}.mutate), nil
    assert_equal ({_if: [{lt: [2, 1]}], value: true}.mutate), nil
  end

  test "hash__if_ge" do
    assert_equal ({_if: [{ge: [1, 2]}], value: true}.mutate), nil
    assert_equal ({_if: [{ge: [1, 1]}], value: true}.mutate), {value: true}
    assert_equal ({_if: [{ge: [2, 1]}], value: true}.mutate), {value: true}
  end

  test "hash__if_le" do
    assert_equal ({_if: [{le: [1, 2]}], value: true}.mutate), {value: true}
    assert_equal ({_if: [{le: [1, 1]}], value: true}.mutate), {value: true}
    assert_equal ({_if: [{le: [2, 1]}], value: true}.mutate), nil
  end

  test "hash__if_or" do
    struct = {_if: [
        {or: [
          {gt: [3, 1]},  # true
          {lt: [3, 1]}   # false
        ]}
      ],
    value: true}

    assert_equal struct.mutate, {value: true}
  end

  test "hash__if_else" do
    struct = {
      _if: [{gt: [3, 1]}],
      value: :if,
      _else: {
        value: :else
      }
    }

    assert_equal struct.mutate, {value: :if}

    struct = {
      _if: [{gt: [1, 3]}],  # false
      value: :if,
      _else: {
        value: :else
      }
    }

    assert_equal struct.mutate, {value: :else}
  end

  test "hash__if_match" do
    struct = {
      _if: [{match: ["test", "^test$"]}],
      value: "if"
    }

    assert_equal struct.mutate, {value: "if"}
  end

  test "hash__if_unmatch" do
    struct = {
      _if: [{unmatch: ["test", "^value$"]}],
      value: "if"
    }

    assert_equal struct.mutate, {value: "if"}
  end

  test "hash__until_returns_array_of_values" do
    struct = {key: {_until: 3, value: "$item"}}
    expect = {
      key: [
        {value: 0},
        {value: 1},
        {value: 2},
      ]
    }
    assert_equal struct.mutate, expect 
  end

  test "readme_example_is_correct" do
    struct = {
      mutations: {
        first: "hello",
        second: "world",
        third: "!"
      },
      key: {
        value: {
          _if: [
            {eq: [{_last: '$mutations'}, "!"]}
          ],
          _concat: {
            items: [
              '$mutations.first', 
              '$mutations.second', 
              '$mutations.third'
            ],
            sep: " "
          }
        }
      }
    }

    assert_equal struct[:key].mutate(struct), {value: "hello world !"}
  end

  test "hash__replace_contents" do
    struct = {
      key: {
        _replace: {
          content: "a-b-c",
          substitutions: [["-", "."], ["b", "z"]]
        }
      }
    }

    assert_equal struct.mutate, {key: "a.z.c"}
  end

  test "hash_escape_works" do
    struct = {
      key: {
        :'\_subkey' => 'value',
      }
    }

    assert_equal struct.mutate, {key: {_subkey: 'value'}}
  end

  test "hash__upcase" do
    struct = {
      key: {
        _upcase: "abc"
      }
    }

    assert_equal struct.mutate, {key: "ABC"}
  end

  test "hash__downcase" do
    struct = {
      key: {
        _downcase: "ABC"
      }
    }

    assert_equal struct.mutate, {key: "abc"}
  end

  test "hash__capitalize" do
    struct = {
      key: {
        _capitalize: "abc"
      }
    }

    assert_equal struct.mutate, {key: "Abc"}
  end

  test "hash__up_down_cap" do
    struct = {
      key: {
        _capitalize: {
          _concat: {
            items: [
              {_upcase: "abc"},
              {_downcase: "DEF"},
            ],
            sep: "-"
          }
        }
      }
    }

    assert_equal struct.mutate, {key: "Abc-def"}
  end

  test "hash__map_block_call" do
    struct = {
      key: {
        _map: {
          items: ["a", "b", "c"],
          call: "_upcase"
        }
      }
    }

    assert_equal struct.mutate, {key: ["A", "B", "C"]}
  end
end
