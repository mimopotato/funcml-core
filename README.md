# Funcml

Funcml-core extends the standard Ruby classes (String, Integer, Hash, Array, etc.) to provide a framework for data structures. This framework makes it possible to perform mutations on data structures and is at the heart of the funcml-cli project.

Connected to funcml-cli, funcml-core can ingest JSON and YAML files and apply prepared mutations. Funcml-cli is part of a wider project, Karist, which aims to simplify the management of Kubernetes manifests using YAML.

However, funcml-core can be used in just about any project thanks to its super-simple, documented AP

## Installation

Ruby superior to >=2.7 is required due to pattern-matching usage.

```bash
gem install funcml-core
```

## Usage

Data structures are mutated using the #mutate function, which is loaded with the funcml-core library. It is then possible to launch a mutation on any object by specifying the mutation functions as arguments to the #mutate method.

```ruby
require "funcml-core"

simple_hash = {key: "$value"}
simple_hash.mutate(value: ["a", "great", "example"])

# { key: ["a", "great", "example"] }
```

Many mutations are supported. Funcml-core includes:

* variables support
* Time functions
* Mathematics
* Hash/dictionaries manipulations
* Cryptography (encryption/decryption with AES)
* Encoding (base64, SHA1, SHA256, MD5...)
* External files inclusion
* Arrays/lists manipulations
* And many others !

Read the doc at [Funcml.org](https://funcml.org) to learn more about what funcml-core supports.

## How it works ?

A #mutate method is implemented for each Ruby object. This method recursively applies the various mutations specified as arguments to the first call.

Funcml-core exposes mutation functions in two ways: either through additional hash keys, determined by the prefix "_", or through strings beginning with "$".

```ruby
struct = {
  mutations: {
    first: "hello",
    second: "world",
    third: "!"
  },
  key: {
    value: {
      _if: [
        {eq: [{_last: '$mutations'}, "!"]}
      ],
      _concat: {
        items: [
          '$mutations.first', 
          '$mutations.second', 
          '$mutations.third'
        ],
        sep: " "
      }
    }
  }
}

struct[:key].mutate(struct)
# {value: "hello world !"}
```

The implementation of funcml-core is somewhat similar in idea to LISP and you will no doubt be able to find some similarities.

The functions are applied recursively: when _concat is called, all items are first mutated before _concat's own evaluation. This is relatively similar to LISP languages where "inside the code is the first part executed".

## Development

All functions are tested using original Ruby data structures. Take a look in the test folder to see all the funcml-core possibilities.


You can run the tests with the following command (test-unit).

```
TESTOPTS="-v" rake test
```

Funcml-core only extends Ruby's native classes. Under no circumstances does funcml-core handle marshal, unmarshal or file read/write operations (see funcml-cli for these parts).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mimopotato/funcml-core.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
