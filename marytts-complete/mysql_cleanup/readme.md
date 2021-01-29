The sole purpose of this code is to remove any non-maori words from the xml transcribed from wikipedia as there appears to be a lot. This entire process is encapsulated behind the run() method in word_cleaner.py and is dynamic no matter how far along in the process you were, I.e. it can start and stop anywhere and is aware

### word_cleaner.py

Will clean out the mi_wordlist database table, and ensure to the best of its ability
that the only content left is Maori. This makes the program more accurate.


### FeatureMakerCleaner.py

Run this before step 5, this is used to split the clean text into sentences. This aims to remove
all the backend html, css and js leftover


### DatabaseSelection.py

Run step 6, then run this. It aims to *actually* complete what step 6 should do. This
will transfer **all** sentences over to the correct database table, so you actually have data
to work with for the next steps.

It appears step 5 marks most sentences as unreliable, so this will move them all over regardless
as they should be of good enough quality to train on.