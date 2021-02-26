### TODO

- Add a gender tag to the lang file, once the voice has been defined
- Similar to above, add an age tag
- Add a maintainer tag?
- 'r' sounds like an [l] occasionally, and is otherwise not pronounced with a trill
- 'n' is indistinguishable

1. Create a language file (https://github.com/espeak-ng/espeak-ng/blob/master/docs/voices.md). This file defines basic language information and audible voice characteristics.
    - `espeak-ng-data/lang/map/mi`
    - Name: `Maori`
    - Language: `mi`
    - Status: `testing`
    - Words: `0 1` - no pause between words, but a short pause where a word ends with a vowel and the next word starts with a vowel
2. Add a phonemetable definition in the master phoneme file, `phsource/phonemes`. This entry controls what phonemes a language will use
    - Phonemes defined as based off the `base2` table, and inlcuding the spanish set
    - Build the phoneme files using `make phsource/phonemes.stamp`
3. Create spelling to phoneme rules, `dictsource/mi_rules`. This contains pronunciations for numbers, letter and symbol names, and words with exceptional pronunciations. It also gives attributes such as "unstressed" and "pause" to some common words.
    - 