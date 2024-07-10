# frozen_string_literal: true
require "digest"

class Hash
  def _sha1sum(mutations)
    self.fetch(:_sha1sum).then do |value|
      return Digest::SHA1.hexdigest(value)
    end
  end
end