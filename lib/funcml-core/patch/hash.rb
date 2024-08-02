# frozen_string_literal: true

class Hash
  include Funcml

  def mutate(mutations = {})
    # dup is here to avoid iteration error on #delete/#merge
    self.dup.each do |key, value|
      case key
      in /^\\_.*$/
        # escapes keys starting with backslash (\).
        # gsub is only implemented on String, not Symbol - this is why
        # we cast the key to string before re-casting it to sym later.
        escaped_key = key.to_s
          .gsub('\\_', '_')

        self[escaped_key.to_sym] = value.mutate(mutations)
        self.delete(key)
      in /^_.*$/
        # recursive mutation of result from pattern-matched _method
        # once recursively mutated, we return the final object by guard
        # clause instead of mutating the current object.
        return self.send(key, mutations)
          .mutate(mutations)
      else
        # no monkey-patch method found (_ prefix), we mutate anyway
        # in case of variables or sub-functions.
        self[key] = value.mutate(mutations)
      end
    end

    self
  end

  def _if(mutations)
    _runcond = Proc.new do |cond, mutations|
      case cond
      in {in: [needle, haystack]}
      haystack.mutate(mutations).include?(needle.mutate(mutations))
      
      in {null: vars} 
        vars.all? {|x| x.mutate(mutations).nil? }
  
      in {present: vars}
        vars.all? {|x| !x.mutate(mutations).nil? }
  
      in {eq: [first, second]} 
        first.mutate(mutations).eql?(second.mutate(mutations))
  
      in {ne: [first, second]} 
        !first.mutate(mutations).eql?(second.mutate(mutations))
  
      in {gt: [first, second]}
        first.mutate(mutations) > second.mutate(mutations)
  
      in {lt: [first, second]}
        first.mutate(mutations) < second.mutate(mutations)
  
      in {ge: [first, second]}
        first.mutate(mutations) >= second.mutate(mutations)
  
      in {le: [first, second]}
        first.mutate(mutations) <= second.mutate(mutations)
      
      in {match: [first, second]}
        first.match?(Regexp.new(second))

      in {unmatch: [first, second]}
        !first.match?(Regexp.new(second))

      # or should evaluated by top-level if as true or false. 
      in {or: or_conds}
        or_conds.any? do |cond|
          _runcond.call(cond, mutations)
        end

      else
        raise UnknownConditionException, "#{cond.to_s} is not a valid condition"
      end
    end

    self.fetch(:_if).then do |conditions|
      all_conditions_state = conditions.all? do |cond|
        _runcond.call(cond, mutations)
      end

      
      if all_conditions_state
        self.delete(:_if)
        self.delete(:_else)
        return self
      else
        return self[:_else] # returns nil if nothing has been set.
      end

      nil
    end
  end

  def _loop(mutations)
    self.fetch(:_loop).then do |_loop|
      items = _loop.fetch(:items, []).mutate(mutations)
      _results = []
      
      # guard clause related to allowed types
      unless items.is_a?(Array)
        raise LoopTypeException, "_loop only supports Array as items"
      end

      # always mutate all items as they could be variable calling hashes.
      # when caller is a string, will be callable as $item for String
      # when caller is a Hash, will be callable as $item.path.to.value for String
      items.each do |item|
        _results <<  _loop[:block]
          .dup          # required to avoid duplicates in code
          .mutate(mutations.merge(item: item))
      end

      return _results
    end
  end

  def _until(mutations)
    _results = []
    amount = self.fetch(:_until)
    amount.times do |i|
      _results << self.dup.select{|k, v| k != :_until}
        .mutate(mutations.merge(item: i))
    end

    return _results
  end

  # _sum takes and mutates all elements in array and
  # sums them.
  # eg: {_sum: [1, 2, 3]} = 6
  def _sum(mutations)
    self.fetch(:_sum).map do |item|
      item.mutate(mutations)
    end.sum
  end

  # _merge merges a hash found at mutation path with caller hash
  # and removes the _merge reference.
  # eg: {key: value, _merge: path.to_mutation } = {key: value, imported_key: value}
  def _merge(mutations)
    self.fetch(:_merge).mutate(mutations).then do |result|
      self.merge!(result).then do
        self.delete(:_merge)
      end
    end

    self
  end

  # _concat concatenates items elements as a string with sep as separator.
  # eg: {_concat: {items: ["a", "b", "c"], sep: " "}} = "a b c"
  def _concat(mutations)
    self.fetch(:_concat).then do |concat|
      return concat.fetch(:items, [])
        .mutate(mutations)
        .join(concat.fetch(:sep, "").mutate(mutations))
    end
  end
  
  def _readfile(mutations)
    self.fetch(:_readfile).then do |path|
      File.read(path)
    end
  end

  def _replace(mutations)
    self.fetch(:_replace).then do |ctx|
      content = ctx.fetch(:content)
      ctx.fetch(:substitutions).each do |from, to|
        content = content.gsub(from, to)
      end

      content
    end
  end

  def dig_from_str(path, mutations)
    path_array_sym = path.split('.').map do |sub|
      sub.to_sym
    end

    self.dig(*path_array_sym).mutate(mutations)
  end

end