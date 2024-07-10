# frozen_string_literal: true

class Hash
  def _keys(mutations)
    self.fetch(:_keys).mutate(mutations).map do |k|
      k.keys
    end.flatten
  end
end