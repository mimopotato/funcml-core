# frozen_string_literal: true

require "time"

class Hash
  def _time(mutations)
    self.fetch(:_time).then do |blk|
      _value = blk.fetch(:value)
      _format = blk.fetch(:format, "%d/%m/%Y %H:%M:%S")

      _value.mutate(mutations).then do |value|
        return Time.parse(value).strftime(_format.mutate(mutations))
      end
    end
  end
end