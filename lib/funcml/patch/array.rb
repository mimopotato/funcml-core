# frozen_string_literal: true

class Array
  def mutate(mutations)
    self.map do |el|
      el.mutate(mutations)
    end
  end
end