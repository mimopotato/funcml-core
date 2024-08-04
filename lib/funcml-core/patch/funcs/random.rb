# frozen_string_literal: true

class Hash
  include Funcml

  def _randomNumber(mutations)
    self.fetch(:_randomNumber).then do |ctx|
      ctx = {} if ctx.nil?
      Random.new.rand(ctx.fetch(:min, 0)..ctx.fetch(:max, 1000))
    end
  end
end
