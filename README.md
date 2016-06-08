## Table of Contents

* [Scope](#scope)
* [INCI catalog](#inci-catalog)
* [Computation](#computation)
  * [Component matching](#component-matching)
  * [Sources](#sources)
* [API](#api)
  * [Unrecognized components](#unrecognized-components)
* [Web API](#web-api)
  * [Starting Puma](#starting-puma)
  * [Triggering a request](#triggering-a-request)
* [CLI API](#cli-api)
* [Performance](#performance)
  * [Wrk](#wrk)
  * [Records](#records)

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
inci = InciScore::Computer::new(src: 'aqua, dimethicone').call
=> #<InciScore::Response:0x000000029f8100 @components={"aqua"=>0, "dimethicone"=>4}, @score=53.762874945799766, @unrecognized=[], @valid=true>
inci.score
=> 53.762874945799766
```

As you see the results are wrapped by an *InciScore::Response* object, this is useful when dealing with the Web API (read below) and when printing them to standard output.

### Unrecognized components
The API treats unrecognized components as a common case by just marking the object as non valid and raise a warning in case more than 30% of the ingredients are not found.  
In such case the score is computed anyway by considering only recognized components.  
Is still possible to query the object for its state:

```ruby
inci = InciScore::Computer::new(src: 'ingredients:aqua,noent1,noent2').call
there are unrecognized ingredients!
=> #<InciScore::Response:0x000000030c16d0 @components={"aqua"=>0}, @score=100.0, @unrecognized=["noent1", "noent2"], @valid=false>
inci.valid
=> false
inci.unrecognized
=> ["noent1", "noent2"]
```

## Web API
The Web API exposes the *InciScore* library over HTTP via the [Roda](http://roda.jeremyevans.net/) framework and the [Puma](http://puma.io/) application server.

### Starting Puma
Simply start Puma via the *config.ru* file included in the repository by spawning how many workers as your current workstation supports:
```
bundle exec puma -w 8 -t 16:32 --preload
```

### Triggering a request
The Web API responds with a JSON object representing the original *InciScore::Response* one.  

You can pass the source string directly as a HTTP parameter:

```
curl http://127.0.0.1:9292/v1/compute?src=ingredients:aqua,dimethicone
=> {"components":{"aqua":0,"dimethicone":4},"score":53.762874945799766,"unrecognized":[],"valid":true}
```

## CLI API
You can collect INCI data by using the available binary:

```
bin/inci_score "aqua,dimethicone,pej-10,noent"

TOTAL SCORE:
        47.18034913243358
VALID STATE:
        true
COMPONENTS (hazard - name): 
        0 - aqua
        4 - dimethicone
        3 - peg-10
UNRECOGNIZED:
        noent
```

## Performance
Roda is one of the fastest Ruby Web micro-framework out there. Said that i noticed the APIs slow down dramatically when dealing with unrecognized components to fuzzy match on.  
I profiled the code by using the [benchmark-ips](https://github.com/evanphx/benchmark-ips) gem, finding the bottleneck was the pure Ruby implementation of the Levenshtein distance algorithm.  
After some pointless optimization, i replaced this routine with a C implementation: i opted for the straightforward [Ruby Inline](https://github.com/seattlerb/rubyinline) library to call the C code straight from Ruby.  
As a result i've got a 10x increment of the throughput, all without scarifying code readability.

### Wrk
I used [wrk](https://github.com/wg/wrk) as the loading tool.
I measured each application server three times, picking the best lap.  
The following script commands were used:

```
wrk -t 4 -c 100 -d 30s --timeout 2000 http://127.0.0.1:9292/v1/compute?src=<list_of_ingredients>
```

### Records
Here are some numbers i recorded on my MacBook PRO, i7 quad-core 2.2Ghz, 8GB DDR3 by running Ruby 2.3:

| Ingredients              | Throughput (req/s) | Latency in ms (avg/stdev/max) |
| :----------------------- | -----------------: | ----------------------------: |
| aqua                     |           8899.04  |           13.47/12.95/267.63  |
| agua                     |           2123.28  |           54.04/55.93/530.25  |
| aqua,dimethicone,peg-10  |           5577.47  |           22.00/21.41/216.99  |
