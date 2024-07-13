# frozen_string_literal: true

class Hash
  def _string(mutations)
    self.fetch(:_string).then do |obj|
      obj.mutate(mutations).to_s
    end
  end

  def _int(mutations)
    self.fetch(:_int).then do |obj|
      obj.mutate(mutations).to_i
    end
  end

  def _float(mutations)
    self.fetch(:_float).then do |obj|
      obj.mutate(mutations).to_f
    end
  end
end