## Table of Contents

* [Scope](#scope)
* [Computation](#computation)
  * [Component matching](#component-matching)

## Scope
This gem computes the hazard of cosmetic components basing on the information provided by the [Biodizionario site](http://www.biodizionario.it/) by Fabrizio Zago.

## Computation
The computation takes care to score the INCI basing on:
* its position in the list of components
* its global hazard basing on the biodizionario

The total score is then calculated on a one thousand basis.

### Component matching
Since the components list might come from external sources (e.g. scanned image, Web form, etc), the gem uses some techniques from the natural language processing to compare with the known component.
Such techniques include:
* [levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance): to compute the edit distance between the two strings
* [metaphone algorithm](https://en.wikipedia.org/wiki/Metaphone): to detect phonetic fingerprinting of two strings 
