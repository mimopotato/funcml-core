# frozen_string_literal: true

class Hash
  include Funcml

  def _first(mutations)
    self.fetch(:_first).mutate(mutations).then do |elems|
      return elems.first
    end
  end

  def _last(mutations)
    self.fetch(:_last).mutate(mutations).then do |elems|
      if elems.is_a?(Hash)
        return elems.values.last
      else
        return elems.last
      end
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

  def _reverse(mutations)
    self.fetch(:_reverse).mutate(mutations).then do |elems|
      return elems.reverse
    end
  end

  def _uniq(mutations)
    self.fetch(:_uniq).mutate(mutations).then do |elems|
      return elems.uniq
    end
  end

  def _index(mutations)
    self.fetch(:_index).mutate(mutations).then do |elems|
      return elems[0].index(elems[1])
    end
  end

  def _len(mutations)
    self.fetch(:_len).then do |elems|
      elems.mutate(mutations).length
    end
  end
end