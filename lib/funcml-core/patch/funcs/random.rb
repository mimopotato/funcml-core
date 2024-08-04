# frozen_string_literal: true

class Hash
  include Funcml

  def _randomNumber(mutations)
    self.fetch(:_randomNumber).then do |ctx|
      ctx = {} if ctx.nil?
      Random.new.rand(ctx.fetch(:min, 0)..ctx.fetch(:max, 1000))
    end
  end

  def _randomString(mutations)
    self.fetch(:_randomString).then do |ctx|
      defaultWhitelist = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
      ctx.fetch(:allowed, []).then do |allowed|
        if allowed.length.eql?(0)
          return (1..ctx.fetch(:length, 8)).map do |output|
            defaultWhitelist[Random.new.rand(defaultWhitelist.length)]
          end.join
        else
          return (1..ctx.fetch(:length, 8)).map do |output|
            allowed[Random.new.rand(allowed.length)]
          end.join
        end
      end
    end
  end
end
