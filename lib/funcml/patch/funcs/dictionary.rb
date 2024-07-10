# frozen_string_literal: true

class Hash
  def _keys(mutations)
    self.fetch(:_keys).mutate(mutations).then do |elems|
      return elems.map do |elem|
        if elem.is_a?(Hash)
          elem.keys
        else
          elem
        end
      end.flatten
    end
  end

  def _values(mutations)
    self.fetch(:_values).mutate(mutations).then do |elems|
      return elems.map do |elem|
        if elem.is_a?(Hash)
          elem.values
        else
          elem
        end
      end.flatten
    end
  end

  def _first(mutations)
    self.fetch(:_first).mutate(mutations).then do |elems|
      return elems.first
    end
  end
end