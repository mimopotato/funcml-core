# frozen_string_literal: true

require_relative "funcml-core/version"
require_relative "funcml-core/patch/hash"
require_relative "funcml-core/patch/string"
require_relative "funcml-core/patch/nil"
require_relative "funcml-core/patch/false"
require_relative "funcml-core/patch/true"
require_relative "funcml-core/patch/array"
require_relative "funcml-core/patch/integer"
require_relative "funcml-core/patch/symbol"
require_relative "funcml-core/patch/float"

require_relative "funcml-core/patch/funcs/encoding"
require_relative "funcml-core/patch/funcs/cryptography"
require_relative "funcml-core/patch/funcs/time"
require_relative "funcml-core/patch/funcs/dictionary"
require_relative "funcml-core/patch/funcs/list"
require_relative "funcml-core/patch/funcs/math"
require_relative "funcml-core/patch/funcs/cast"
require_relative "funcml-core/patch/funcs/random"

module Funcml
  class Error < StandardError; end
  class MutationException < Error; end
  class LoopTypeException < Error; end
  class UnknownConditionException < Error; end
  class MissingEncryptionKeyException < Error; end
  class IncorrectSecondsException < Error; end
  # Your code goes here...
end
