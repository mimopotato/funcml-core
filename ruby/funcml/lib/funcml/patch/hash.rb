# frozen_string_literal: true

class Hash
  include Funcml

  def mutate(mutations = {})
    # dup is here to avoid iteration error on #delete/#merge
    self.dup.each do |key, value|
      case key
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

  def _loop(mutations)
    self.fetch(:_loop).then do |_loop|
      items = _loop.fetch(:items, [])
      _results = []
      
      # guard clause related to allowed types
      unless items.is_a?(Array)
        raise LoopTypeException, "_loop only supports Array as items"
      end

      # always mutate all items as they could be variable calling hashes.
      items = items.mutate(mutations)

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
        .join(concat.fetch(:sep, ""))
    end
  end

  def dig_from_str(path, mutations)
    path_array_sym = path.split('.').map do |sub|
      sub.to_sym
    end

    self.dig(*path_array_sym).mutate(mutations)
  end
end