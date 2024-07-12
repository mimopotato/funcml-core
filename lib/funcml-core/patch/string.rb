# frozen_string_literal: true
require "securerandom"

class String
  include Funcml

  def mutate(mutations)
    if self.start_with?('$')

      return Time.now.to_s if self.eql?('$now')
      return SecureRandom.uuid if self.eql?('$uuidv4')

      mutations.dig_from_str(self.gsub('$', ''), mutations).then do |value|
        raise MutationException, "#{self} not found in mutations" if value.nil?
        return value.mutate(mutations)
      end
    end

    self
  end

  def dig(_)
    self
  end
end