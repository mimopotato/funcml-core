# frozen_string_literal: true

class Hash
  def _env(mutations)
    self.fetch(:_env).then do |env_var|
      return ENV.fetch(env_var.upcase, "null").mutate(mutations)
    end
  end

  def _strictEnv(mutations)
    self.fetch(:_strictEnv).then do |env_var|
      ENV.fetch(env_var.upcase, nil).then do |value|
        if value.nil?
          raise MissingEnvVariableStrictException, "missing env variable for #{env_var}"
        end

        value.mutate(mutations)
      end
    end
  end
end