## Table of Contents

* [Scope](#scope)
* [INCI catalog](#inci-catalog)
* [Computation](#computation)
  * [Component matching](#component-matching)
  * [Sources](#sources)
    * [Tesseract](#tessract)
* [API](#api)
 * [Unrecognized components](#unrecognized-components)

## Scope
This gem computes the score of cosmetic components basing on the information provided by the [Biodizionario site](http://www.biodizionario.it/) by Fabrizio Zago.

## INCI catalog
[INCI](https://en.wikipedia.org/wiki/International_Nomenclature_of_Cosmetic_Ingredients) catalog is fetched directly by the bidizionario site and kept in memory.  
Currently there are more than 5000 components with a hazard score that ranges from 0 to 4.

## Computation
The computation takes care to score each compoent the cosmetic basing on:
* its hazard basing on the biodizionario score
* its position on the list of ingredients

The total score is then calculated on a percent basis.

### Component matching
Since the ingredients list might come from external sources (e.g. scanned image, Web form, etc), the gem tries to fuzzy match the ingredients by using different algorithms:
1. extact matching
2. first 10 matching digits 
3. [edit distance](https://en.wikipedia.org/wiki/Levenshtein_distance) behind a specified tolerance
4. matching by splitted tokens
5. first 5 matching digits

### Sources
I assume the INCI could come from different sources, although the main one should be a bitmap coming from a mobile device.  

#### Tesseract
Extracting text from a bitmap is a hard task, since cosmetics often prints their INCI with small characters and/or the printed surface is not flat. 
After some test i decided to rely on the [Tesseract
OCR](https://github.com/tesseract-ocr/tesseract), calling it directly from ruby instead of relying on some juggernaut implementation.

## API
The API of the gem is pretty simple, assuming you have installed Tesseract on your device, you can start computing the INCI score by:

```ruby
InciScore::Computer::new(src: 'sample/01.jpg').call
=> 83.06157861428775
```

### Unrecognized components
The API treats unrecognized components as a standard case by just marking the object as not valid and raise a warning in case more than 30% of the ingredients are not found.  
User can query the object for its state:

```ruby
inci = InciScore::Computer::new(src: 'sample/07.jpg')
inci.call
=> there are unrecognized ingredients!
=> 81.2647487565317
inci.valid?
=> false
inci.unrecognized
=> ["ceearylalcohol distearoylethyl annoxvmvwomw methosulfate", "mn", "pighlapunicifouai aceholafruitextract", "f benzoicacid", "wmnome j hcmnmcgmciirusmedicalimonum", "peel extract lemon peel extract", "j prunusarmeniacakerneloil apricot xmaommanmmamm", "oil suybean oil", "fll 04391213"]
```
