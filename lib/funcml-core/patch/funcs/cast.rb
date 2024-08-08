# frozen_string_literal: true
require "json"
require "yaml"

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

  def _json(mutations)
    self.fetch(:_json).then do |obj|
      obj.mutate(mutations).to_json
    end
  end

  def _fromJson(mutations)
    self.fetch(:_fromJson).then do |obj|
      # usage of symbolize_names instead of deep_symbolize_keys as it is only
      # implemented in funcml-cli.
      JSON.parse(obj, symbolize_names: true).then do |struct|
        struct.mutate(mutations)
      end
    end
  end

  def _yaml(mutations)
    self.fetch(:_yaml).then do |obj|
      obj.mutate(mutations).to_yaml
    end
  end

  def _fromYaml(mutations)
    self.fetch(:_fromYaml).then do |obj|
      return YAML.safe_load(obj)
    end
  end
end