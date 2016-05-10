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
The computation takes care to score each component the cosmetic basing on:
* its hazard basing on the biodizionario score
* its position on the list of ingredients

The total score is then calculated on a percent basis.

### Component matching
Since the ingredients list might come from external sources (e.g. scanned image, Web form, etc), the gem tries to fuzzy match the ingredients by using different algorithms:
* exact matching
* [edit distance](https://en.wikipedia.org/wiki/Levenshtein_distance) behind a specified tolerance
* first relevant matching digits 
* matching by splitted tokens

### Sources
I assume the INCI could come from different sources, although the main one should be a bitmap coming from a mobile device.  

#### Tesseract
Extracting text from a bitmap is a hard task, since cosmetics often prints their INCI with small characters and/or the printed surface is not flat. 
After some test i decided to rely on the [Tesseract
OCR](https://github.com/tesseract-ocr/tesseract), calling it directly from ruby instead of relying on some juggernaut wrapper.

## API
The API of the gem is pretty simple, assuming you have installed Tesseract on your device, you can start computing the INCI score by:

```ruby
inci = InciScore::Computer::new(src: 'sample/01.jpg').call
=> #<InciScore::Response:0x0000000289b7a8 @components=["aqua", "disodium laureth sulfosuccinate", "cocamidopropyl betaine", "disodium cocoamphodiacetate", "glyceryl laurate", "peg-7 glyceryl cocoate", "sodium lactate", "parfum", "niacinamide", "glycine", "magnesium aspartate", "alanine", "lysine", "leucine", "allantoin", "peg-150 distearate", "peg-120 methyl glucose dioleate", "phenoxyethanol", "ci 61570"], @score=83.06157861428775, @unrecognized=["50"], @valid=true>
inci.score
=> 83.06157861428775
```

As you see the results are wrapped by a *InciScore::Response* object, this is useful when dealing with the Web API (read below).

### Unrecognized components
The API treats unrecognized components as a standard case by just marking the object as not valid and raise a warning in case more than 30% of the ingredients are not found.  
User can query the object for its state:

```ruby
inci = InciScore::Computer::new(src: 'sample/07.jpg').call
=> #<InciScore::Response:0x00000004039d10 @components=["aqua", "octyldecanol 1-", "niacin", "linalool", "caprylyl glycol", "parfum"], @score=92.08137986008471, @unrecognized=["ceearylalcohol distearoylethyl annoxvmvwomw methosulfate", "mnpighlapunicifouai", "aceholafruitextract", "camellnasatnaoll", "f benzoicacid", "5 cadryuucaprictriglvcerideeyrusm", "wmnome j hcmnmcgmciirusmedicalimonum", "peel extract", "j prunusarmeniacakerneloil", "oil", "cfll 04391213"], @valid=false>
inci.valid
=> false
inci.unrecognized
=> ["ceearylalcohol distearoylethyl annoxvmvwomw methosulfate", "mnpighlapunicifouai", "aceholafruitextract", "camellnasatnaoll", "f benzoicacid", "5 cadryuucaprictriglvcerideeyrusm", "wmnome j hcmnmcgmciirusmedicalimonum", "peel extract", "j prunusarmeniacakerneloil", "oil", "cfll 04391213"]
```

## Web API
The Web API exposes the *InciScore* library by a HTTP layer via the [Roda](http://roda.jeremyevans.net/) framework and the [Puma](http://puma.io/) app server.

### Starting Puma
Simply start Puma via the *config.ru* file included in the repository by spawning how many workers as your current workstation can support:
```
bundle exec puma -w 3 -t 16:32 -q
```

### Triggering a request
The Web API responds with a JSON object representing the original *InciScore::Response* one.  
You can use the curl utility to trigger a POST request to the Web API:
```
curl --form "src=@sample/01.jpg" http://192.168.33.22:9292/v1/compute
=> {"components":["aqua","disodium laureth sulfosuccinate","cocamidopropyl betaine","disodium cocoamphodiacetate","glyceryl laurate","peg-7 glyceryl cocoate","sodium lactate","parfum","niacinamide","glycine","magnesium aspartate","alanine","lysine","leucine","allantoin","peg-150 distearate","peg-120 methyl glucose dioleate","phenoxyethanol","ci 61570"],"score":83.06157861428775,"unrecognized":["50"],"valid":true}
```

## Rake tasks
There is also a command line API via the Rake tool:

### Score
Compute the total INCI score by scanning an image:
```
rake inci:score src=sample/01.jpg
83.06157861428775
```

### Components
Fetch the INCI components by scanning an image and print the in a friendly hazard-name format:
```
rake inci:components src=sample/01.jpg
0 - aqua
2 - sodium laureth sulfate
2 - sodium chlorate
1 - guanine
0 - gluconolactone
0 - glycerin
2 - guar hydroxypropyltrimonium chloride
4 - dimethiconol
0 - parfum
3 - tea-dodecylbenzenesulfonate
0 - mica
0 - albumen
3 - ppg-12
0 - citric acid
0 - sodium acetate
1 - sodium benzoate
3 - dmdm hydantoin
3 - methylisothiazolinone
4 - butylparaben
3 - ci 47005
0 - ci 77891
```
