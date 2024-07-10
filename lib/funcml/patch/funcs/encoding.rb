# frozen_string_literal: true
require "base64"

class Hash
  def _base64encode(mutations)
    self.fetch(:_base64encode, "").then do |value|
      return Base64.encode64(value.mutate(mutations)).strip
    end
  end
end