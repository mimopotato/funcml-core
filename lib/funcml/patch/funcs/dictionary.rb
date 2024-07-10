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

  def _tail(mutations)
    self.fetch(:_tail).mutate(mutations).then do |elems|
      return elems[0].last(elems[1])
    end
  end

  def _head(mutations)
    self.fetch(:_head).mutate(mutations).then do |elems|
      return elems[0][0..(elems[1]-1)]
    end
  end
end