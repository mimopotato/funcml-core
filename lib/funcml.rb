# frozen_string_literal: true

require_relative "funcml/version"
require_relative "funcml/patch/hash"
require_relative "funcml/patch/string"
require_relative "funcml/patch/nil"
require_relative "funcml/patch/false"
require_relative "funcml/patch/true"
require_relative "funcml/patch/array"
require_relative "funcml/patch/integer"
require_relative "funcml/patch/symbol"

require_relative "funcml/patch/funcs/encoding"

module Funcml
  class Error < StandardError; end
  class MutationException < Error; end
  class LoopTypeException < Error; end
  class UnknownConditionException < Error; end
  # Your code goes here...
end
