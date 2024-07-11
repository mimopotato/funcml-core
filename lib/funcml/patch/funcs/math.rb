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
end