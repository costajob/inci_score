## Table of Contents

* [Scope](#scope)
* [INCI catalog](#inci-catalog)
* [Computation](#computation)
  * [Component matching](#component-matching)
  * [Sources](#sources)
* [API](#api)
  * [Unrecognized components](#unrecognized-components)
* [CLI](#cli)
  * [HTTP server](#http-server)
    * [Triggering a request](#triggering-a-request)
  * [Getting help](#getting-help)
* [Benchmark](#benchmark)
  * [Levenshtein in C](#levenshtein-in-c)
  * [Platform](#platform)
  * [Wrk](#wrk)
  * [Results](#results)

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

## API
The API of the gem is pretty simple, you can open irb by *bundle console* and start computing the INCI score:

```ruby
inci = InciScore::Computer.new(src: 'aqua, dimethicone').call
=> #<InciScore::Response:0x000000029f8100 @components={"aqua"=>0, "dimethicone"=>4}, @score=53.762874945799766, @unrecognized=[], @valid=true>
inci.score
=> 53.762874945799766
```

As you see the results are wrapped by an *InciScore::Response* object, this is useful when dealing with the CLI and HTTP interfaces (read below).

### Unrecognized components
The API treats unrecognized components as a common case by just marking the object as non valid and raise a warning in case more than 30% of the ingredients are not found.  
In such case the score is computed anyway by considering only recognized components.  
Is still possible to query the object for its state:

```ruby
inci = InciScore::Computer.new(src: 'ingredients:aqua,noent1,noent2').call
=> #<InciScore::Response:0x000000030c16d0 @components={"aqua"=>0}, @score=100.0, @unrecognized=["noent1", "noent2"], @valid=false>
inci.valid
=> false
inci.unrecognized
=> ["noent1", "noent2"]
```

## CLI
You can collect INCI data by using the available CLI interface:

```shell
inci_score --src="ingredients: aqua, dimethicone, pej-10, noent"

TOTAL SCORE:
        47.18034913243358
VALID STATE:
        true
COMPONENTS (hazard - name): 
        aqua
        dimethicone
        peg-10
UNRECOGNIZED:
        noent
```

### HTTP server
The CLI interface exposes a Web layer based on the [Puma](http://puma.io/) application server.  
The HTTP server is started on the specified port by spawning as many workers as your current workstation supports:
```shell
inci_score --http=9292
```
Consider all other options are discarded when running HTTP server.

#### Triggering a request
The HTTP server responds with a JSON representation of the original *InciScore::Response* object.  
You can pass the source string directly as a HTTP parameter (URI escaped):

```shell
curl http://127.0.0.1:9292?src=aqua,dimethicone
=> {"components":{"aqua":0,"dimethicone":4},"unrecognized":[],"score":53.762874945799766,"valid":true}
```

### Getting help
You can get CLI interface help by:
```shell
Usage: inci_score --src="aqua, parfum, etc" --precise
    -s, --src=SRC                    The INCI list: "aqua, parfum, etc"
    -p, --precise                    Compute components more precisely (slower)
        --http=PORT                  Start HTTP server on the specified port
    -h, --help                       Prints this help
```

## Benchmark

### Levenshtein in C
I noticed the APIs slows down dramatically when dealing with unrecognized components to fuzzy match on.  
I profiled the code by using the [benchmark-ips](https://github.com/evanphx/benchmark-ips) gem, finding the bottleneck was the pure Ruby implementation of the Levenshtein distance algorithm.  
After some pointless optimization, i replaced this routine with a C implementation: i opted for the straightforward [Ruby Inline](https://github.com/seattlerb/rubyinline) library to call the C code straight from Ruby.  

### Platform
I registered these benchmarks with a MacBook PRO 15 mid 2015 having these specs:
* OSX El Captain
* 2,2 GHz Intel Core i7 (4 cores)
* 16 GB 1600 MHz DDR3
* Ruby 2.4

### Wrk
As always i used [wrk](https://github.com/wg/wrk) as the loading tool, executed on a dedicated workstation.
I measured the library three times, picking the best lap.  
```shell
wrk -t 4 -c 100 -d 30s --timeout 2000 http://0.0.0.0:9292/?src=aqua,parfum,zeolithe
```

### Results
| Throughput (req/s) | Latency (avg/stdev/max)   |
| -----------------: | ------------------------: |
|            2908.63 |  42.23ms/47.17ms/461.36ms |
