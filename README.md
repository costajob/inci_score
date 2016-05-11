## Table of Contents

* [Scope](#scope)
* [Vagrant](#vagrant)
* [INCI catalog](#inci-catalog)
* [Computation](#computation)
  * [Component matching](#component-matching)
  * [Sources](#sources)
    * [Tesseract](#tessract)
* [API](#api)
 * [Unrecognized components](#unrecognized-components)
* [Web API](#web-api)
 * [Starting Puma](#starting-puma)
 * [Triggering a request](#triggering-a-request)
* [CLI API](#cli-api)
* [Rake tasks](#rake-tasks)

## Scope
This gem computes the score of cosmetic components basing on the information provided by the [Biodizionario site](http://www.biodizionario.it/) by Fabrizio Zago.

## Vagrant
This repository includes a [Vagrant]() configuration to setup a properly configured execution environment.  
Just run the following command on terminal:

```
vagrant up
```

Be sure to check the *Vagrantfile* to adjust CPUs and RAM basing on your host device specs (defaults to 3vCPU and 6GB of RAM).

## INCI catalog
[INCI](https://en.wikipedia.org/wiki/International_Nomenclature_of_Cosmetic_Ingredients) catalog is fetched directly by the bidizionario site and kept in memory.  
Currently there are more than 5000 components with a hazard score that ranges from 0 (safe) to 4 (dangerous).

## Computation
The computation takes care to score each component of the cosmetic basing on:
* its hazard basing on the biodizionario score
* its position on the list of ingredients

The total score is then calculated on a percent basis.

### Component matching
Since the ingredients list could come from an unreliable source, the gem tries to fuzzy match the ingredients by using different algorithms:
* exact matching
* [edit distance](https://en.wikipedia.org/wiki/Levenshtein_distance) behind a specified tolerance
* first relevant matching digits 
* matching splitted tokens

### Sources
The library accepts the list of ingredients from different sources, although the main one should be a bitmap captured by a mobile device.  

#### Tesseract
Extracting text from a bitmap is a hard task, since cosmetics often prints their INCI with small characters and/or with colorful backgrounds on non-flat surface. 
After some test i decided to use the [Tesseract OCR](https://github.com/tesseract-ocr/tesseract), calling it directly from ruby instead of relying on some juggernaut wrapper.

## API
The API of the gem is pretty simple, assuming you have installed Tesseract on your device, you can start computing the INCI score by:

```ruby
inci = InciScore::Computer::new(src: 'sample/01.jpg').call
=> #<InciScore::Response:0x00000003cc01e8 @components={"aqua"=>0, "disodium laureth sulfosuccinate"=>2, "cocamidopropyl betaine"=>1, "disodium cocoamphodiacetate"=>0, "glyceryl laurate"=>0, "peg-7 glyceryl cocoate"=>3, "sodium lactate"=>0, "parfum"=>0, "niacinamide"=>0, "glycine"=>0, "magnesium aspartate"=>0, "alanine"=>0, "lysine"=>0, "leucine"=>0, "allantoin"=>0, "peg-150 distearate"=>3, "peg-120 methyl glucose dioleate"=>3, "phenoxyethanol"=>2, "ci 61570"=>3}, @score=82.52110249964151, @unrecognized=["50"], @valid=true>
inci.score
=> 82.52110249964151
```

As you see the results are wrapped by an *InciScore::Response* object, this is useful when dealing with the Web API (read below).

### Unrecognized components
The API treats unrecognized components as a common case by just marking the object as non valid and raise a warning in case more than 30% of the ingredients are not found.  
User can query the object for its state:

```ruby
inci = InciScore::Computer::new(src: 'sample/07.jpg').call
there are unrecognized ingredients!
=> #<InciScore::Response:0x00000003d1e8d8 @components={"aqua"=>0, "octyldecanol 1-"=>1, "niacin"=>0, "linalool"=>2, "caprylyl glycol"=>0, "parfum"=>0}, @score=90.49765583210164, @unrecognized=["ceearylalcohol distearoylethyl annoxvmvwomw methosulfate", "mnpighlapunicifouai", "aceholafruitextract", "camellnasatnaoll", "extract", "f benzoicacid", "5 cadryuucaprictriglvcerideeyrusm", "wmnome j hcmnmcgmciirusmedicalimonum", "peel extract", "j prunusarmeniacakerneloil", "oil", "cfll 04391213"], @valid=false>
inci.valid
=> false
inci.unrecognized
=> ["ceearylalcohol distearoylethyl annoxvmvwomw methosulfate", "mnpighlapunicifouai", "aceholafruitextract", "camellnasatnaoll", "f benzoicacid", "5 cadryuucaprictriglvcerideeyrusm", "wmnome j hcmnmcgmciirusmedicalimonum", "peel extract", "j prunusarmeniacakerneloil", "oil", "cfll 04391213"]
```

## Web API
The Web API exposes the *InciScore* library over HTTP via the [Roda](http://roda.jeremyevans.net/) framework and the [Puma](http://puma.io/) application server.

### Starting Puma
Simply start Puma via the *config.ru* file included in the repository by spawning how many workers as your current workstation supports:
```
bundle exec puma -w 3 -t 16:32 -q
```

### Triggering a request
The Web API responds with a JSON object representing the original *InciScore::Response* one.  
You can use the curl utility to trigger a POST request to the Web API:
```
curl --form "src=@sample/01.jpg" http://192.168.33.22:9292/v1/compute
=> {"components":{"aqua":0,"disodium laureth sulfosuccinate":2,"cocamidopropyl betaine":1,"disodium cocoamphodiacetate":0,"glyceryl laurate":0,"peg-7 glyceryl cocoate":3,"sodium lactate":0,"parfum":0,"niacinamide":0,"glycine":0,"magnesium aspartate":0,"alanine":0,"lysine":0,"leucine":0,"allantoin":0,"peg-150 distearate":3,"peg-120 methyl glucose dioleate":3,"phenoxyethanol":2,"ci 61570":3},"score":82.52110249964151,"unrecognized":["50"],"valid":true}
```

## CLI API
You can collect INCI data by using the available binary:

```
bin/inci_score sample/01.jpg

TOTAL SCORE:
        82.52110249964151
VALID STATE:
        true
COMPONENTS (hazard - name): 
        0 - aqua
        2 - disodium laureth sulfosuccinate
        1 - cocamidopropyl betaine
        0 - disodium cocoamphodiacetate
        0 - glyceryl laurate
        3 - peg-7 glyceryl cocoate
        0 - sodium lactate
        0 - parfum
        0 - niacinamide
        0 - glycine
        0 - magnesium aspartate
        0 - alanine
        0 - lysine
        0 - leucine
        0 - allantoin
        3 - peg-150 distearate
        3 - peg-120 methyl glucose dioleate
        2 - phenoxyethanol
        3 - ci 61570
UNRECOGNIZED:
        50
```

This client allow to pass multiple src:
```
bin/inci_score sample/01.jpg sample/03.jpg ...
...
```

## Rake tasks
Alternately you can use the available rake task to get the same results (one source at time):

```
rake inci_score:compute src=sample/04.jpg

TOTAL SCORE:
        70.28040283495838
VALID STATE:
        true
COMPONENTS (hazard - name): 
        2 - capryl glycol
        1 - isopropyl palmitate
        2 - isopropyl myristate
        0 - parfum
        2 - benzyl alcohol
        2 - benzyl salicylate
        2 - coumarin
        2 - hexyl cinnamal
        2 - limonene
        2 - linalool
        0 - olea europaea
UNRECOGNIZED:
        pentaerythrityl tetraditbutyl hydroxyhydrocinnamaie
        11317540710
```
