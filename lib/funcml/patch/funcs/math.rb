# frozen_string_literal: true

class Hash
  def _add(mutations)
    self.fetch(:_add, []).then do |numbers|
      numbers.mutate(mutations).sum
    end
  end
end