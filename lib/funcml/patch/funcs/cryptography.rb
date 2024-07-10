# frozen_string_literal: true
require "digest"

class Hash
  def _sha1sum(mutations)
    self.fetch(:_sha1sum).then do |value|
      return Digest::SHA1.hexdigest(value.mutate(mutations))
    end
  end

  def _sha256sum(mutations)
    self.fetch(:_sha256sum).then do |value|
      return Digest::SHA256.hexdigest(value.mutate(mutations))
    end
  end
end