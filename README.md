## Table of Contents

* [Scope](#scope)
* [INCI catalog](#inci-catalog)
* [Computation](#computation)
  * [Component matching](#component-matching)
  * [Sources](#sources)
* [Installation](#installation)
* [Usage](#usage)
  * [Library](#library)
  * [CLI](#cli)
* [Benchmark](#benchmark)
  * [Levenshtein in C](#levenshtein-in-c)

## Scope
This gem computes the score of cosmetic components basing on the information provided by the [Biodizionario site](http://www.biodizionario.it/) by Fabrizio Zago.

## INCI catalog
[INCI](https://en.wikipedia.org/wiki/International_Nomenclature_of_Cosmetic_Ingredients) catalog is fetched directly by the bidizionario site and kept in memory.  
Currently there are more than 5000 components with a hazard score that ranges from 0 (safe) to 4 (dangerous).

## Computation
The computation takes care to score each component of the cosmetic basing on:
* its hazard basing on the biodizionario score
* its position on the list of ingredients

The total score is then calculated on a percent basis.

### Component matching
Since the ingredients list could come from an unreliable source (e.g. data scanned from a captured image), the gem tries to fuzzy match the ingredients by using different algorithms:
* exact matching
* [edit distance](https://en.wikipedia.org/wiki/Levenshtein_distance) behind a specified tolerance
* first relevant matching digits 
* matching splitted tokens

### Sources
The library accepts the list of ingredients as a single string of text. Since this source could come from an OCR program, the library performs a normalization by stripping invalid characters and removing the unimportant parts.  
The ingredients are typically separated by comma, although normalizer will detect the most appropriate separator:

```
"Ingredients: Aqua, Disodium Laureth Sulfosuccinate, Cocamidopropiyl\nBetaine"
```

## Installation
Install the gem from your shell:
```shell
gem install inci_score
```

## Usage

### Library
You can include this gem into your own library and start computing the INCI score:

```ruby
require "inci_score"

inci = InciScore::Computer.new(src: 'aqua, dimethicone').call
inci.score # 53.7629
```

As you see the results are wrapped by an *InciScore::Response* object, this is useful when dealing with the CLI and HTTP interfaces (read below).

#### Unrecognized components
The API treats unrecognized components as a common case by just marking the object as non valid and raise a warning in case more than 30% of the ingredients are not found.  
In such case the score is computed anyway by considering only recognized components.  
Is still possible to query the object for its state:

```ruby
inci = InciScore::Computer.new(src: 'ingredients:aqua,noent1,noent2').call
inci.valid # false
inci.unrecognized # ["noent1", "noent2"]
```

### CLI
You can collect INCI data by using the available CLI interface:

```shell
inci_score --src="ingredients: aqua, dimethicone, pej-10, noent"

TOTAL SCORE:
        47.1803
VALID STATE:
        true
COMPONENTS (hazard - name): 
        aqua
        dimethicone
        peg-10
UNRECOGNIZED:
        noent
```

#### Getting help
You can get CLI interface help by:
```shell
Usage: inci_score --src="aqua, parfum, etc"
    -s, --src=SRC                    The INCI list: "aqua, parfum, etc"
    -h, --help                       Prints this help
```

## Benchmark

### Levenshtein in C
I noticed the APIs slows down dramatically when dealing with unrecognized components to fuzzy match on.  
I profiled the code by using the [benchmark-ips](https://github.com/evanphx/benchmark-ips) gem, finding the bottleneck was the pure Ruby implementation of the Levenshtein distance algorithm.  
After some pointless optimization, i replaced this routine with a C implementation: i opted for the straightforward [Ruby Inline](https://github.com/seattlerb/rubyinline) library to call the C code straight from Ruby.
