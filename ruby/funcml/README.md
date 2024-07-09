# Funcml
## Installation

```bash
gem install funcml
```

## Usage

```
require "funcml"

mutations = { value: "it works !" }
struct = { key: "$value" }

puts struct.mutate(mutations)[:key] # => "It works !"
```

## Development


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mimopotato/funcml-lang.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
