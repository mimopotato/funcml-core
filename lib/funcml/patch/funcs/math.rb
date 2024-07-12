# frozen_string_literal: true

class Hash
  def _add(mutations)
    self.fetch(:_add, []).then do |numbers|
      numbers.mutate(mutations).reduce(:+)
    end
  end

  def _sub(mutations)
    self.fetch(:_sub, []).then do |numbers|
      numbers.mutate(mutations).reduce(:-)
    end
  end

  def _div(mutations)
    self.fetch(:_div, []).then do |numbers|
      numbers.mutate(mutations).reduce(:/)
    end
  end

  def _mod(mutations)
    self.fetch(:_mod).then do |numbers|
      first, second = numbers.mutate(mutations)
      first % second
    end
  end

  def _mul(mutations)
    self.fetch(:_mul, []).then do |numbers|
      numbers.mutate(mutations).reduce(:*)
    end
  end

  def _min(mutations)
    self.fetch(:_min, []).then do |numbers|
      numbers.mutate(mutations).min
    end
  end

  def _max(mutations)
    self.fetch(:_max, []).then do |numbers|
      numbers.mutate(mutations).max
    end
  end
end