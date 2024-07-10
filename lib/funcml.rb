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
require_relative "funcml/patch/funcs/cryptography"
require_relative "funcml/patch/funcs/time"
require_relative "funcml/patch/funcs/dictionary"
require_relative "funcml/patch/funcs/list"

module Funcml
  class Error < StandardError; end
  class MutationException < Error; end
  class LoopTypeException < Error; end
  class UnknownConditionException < Error; end
  class MissingEncryptionKeyException < Error; end
  class IncorrectSecondsException < Error; end
  # Your code goes here...
end
