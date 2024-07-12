# frozen_string_literal: true

require "time"

class Hash
  include Funcml

  def _time(mutations)
    self.fetch(:_time).then do |blk|
      _value = blk.fetch(:value)
      _format = blk.fetch(:format, "%d/%m/%Y %H:%M:%S")

      _value.mutate(mutations).then do |value|
        return Time.parse(value).strftime(_format.mutate(mutations))
      end
    end
  end

  def _ago(mutations)
    self.fetch(:_ago).then do |blk|
      unless blk.is_a?(Integer)
        raise IncorrectSecondsException, "_ago only supports seconds as value in #{self.to_s}"
      end

      (Time.now - blk).to_s
    end
  end
end