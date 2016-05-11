## Table of Contents

* [Scope](#scope)
* [Vagrant](#vagrant)
* [INCI catalog](#inci-catalog)
* [Computation](#computation)
  * [Component matching](#component-matching)
  * [Sources](#sources)
    * [Plain text](#plain-text)
    * [Tesseract](#tessract)
* [API](#api)
  * [Unrecognized components](#unrecognized-components)
* [Web API](#web-api)
  * [Starting Puma](#starting-puma)
  * [Triggering a request](#triggering-a-request)
    * [GET request](#get-request)
    * [POST request](#post-request)
* [CLI API](#cli-api)
* [Rake tasks](#rake-tasks)

## Scope
This gem computes the score of cosmetic components basing on the information provided by the [Biodizionario site](http://www.biodizionario.it/) by Fabrizio Zago.

## Vagrant
This repository includes a [Vagrant](https://www.vagrantup.com/) configuration to setup a properly configured execution environment.  
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
Since the ingredients list could come from an unreliable source (e.g. data scanned from a captured image), the gem tries to fuzzy match the ingredients by using different algorithms:
* exact matching
* [edit distance](https://en.wikipedia.org/wiki/Levenshtein_distance) behind a specified tolerance
* first relevant matching digits 
* matching splitted tokens

### Sources
The library accepts the list of ingredients from different sources, although the main one should be a bitmap captured by a mobile device.  

#### Plain text
This library fetches the source as plain text as default. The ingredients are expressed as a single string of data, typically separated by comma, such as:

```
"Ingredients: Aqua, Disodium Laureth Sulfosuccinate, Cocamidopropiyl\nBetaine, Disodium Cocoamphodiacetate, Giyceryi Laurate, PEGJ\nGlyceryi Cocoate, Sodium Lactate, Parfum,\n\nNiacinamide, Glycine, Magnesium Aspanate,\n\nAianine, Lysine, Leucine,A||antoin, PEG-150 E‘—\n\nDistearate, PEG-120 Methyl Glucose Dioleate, ——\n\nPhenoxyethanoi, CI 61570. 50\n\n \n\n"
```

#### Tesseract
The library includes an OCR module based on the [Tesseract OCR](https://github.com/tesseract-ocr/tesseract).  
Tesseract is called directly from ruby (via *system*), but has proved to not scale very nicely when requests starts to accumulate. 

## API
The API of the gem is pretty simple, assuming you have installed Tesseract on your device, you can start computing the INCI score by:

```ruby
inci = InciScore::Computer::new(src: 'aqua, dimethicone').call
=> #<InciScore::Response:0x000000029f8100 @components={"aqua"=>0, "dimethicone"=>4}, @score=54.83566009043177, @unrecognized=[], @valid=true>
inci.score
=> 54.83566009043177
```

Alternatively you can rely on your Tesseract installation and pass directly an image path to be scanned:
```ruby
t = Tesseract::new(src: 'sample/01.jpg')
InciScore::Computer::new(processor: t).call
=> #<InciScore::Response:0x00000003cc01e8 @components={"aqua"=>0, "disodium laureth sulfosuccinate"=>2, "cocamidopropyl betaine"=>1, "disodium cocoamphodiacetate"=>0, "glyceryl laurate"=>0, "peg-7 glyceryl cocoate"=>3, "sodium lactate"=>0, "parfum"=>0, "niacinamide"=>0, "glycine"=>0, "magnesium aspartate"=>0, "alanine"=>0, "lysine"=>0, "leucine"=>0, "allantoin"=>0, "peg-150 distearate"=>3, "peg-120 methyl glucose dioleate"=>3, "phenoxyethanol"=>2, "ci 61570"=>3}, @score=82.52110249964151, @unrecognized=["50"], @valid=true>
```

As you see the results are wrapped by an *InciScore::Response* object, this is useful when dealing with the Web API (read below).

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
bundle exec puma -w 3 -t 16:32 -q
```

### Triggering a request
The Web API responds with a JSON object representing the original *InciScore::Response* one.  

#### GET request
You can pass the source string directly as a HTTP parameter:
```
curl http://192.168.33.22:9292/v1/compute?src=ingredients:aqua,dimethicone
=> {"components":{"aqua":0,"dimethicone":4},"score":54.83566009043177,"unrecognized":[],"valid":true}
```

#### POST request
Alternatively you can use curl to upload an image via a POST request, the Tesseract processor is used:
```
curl --form "src=@sample/01.jpg" http://192.168.33.22:9292/v1/tesseract
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
