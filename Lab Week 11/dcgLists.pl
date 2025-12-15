% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

sentence(X,Z) :- noun_phrase(X,Y),
                 verb_phrase(Y,Z).

noun_phrase(X,Z) :- determiner(X,Y),
                    noun(Y,Z).

verb_phrase(X,Z) :- verb(X,Y),
                    noun_phrase(Y,Z).

verb_phrase(X,Z) :- verb(X,Y),
                    sentence(Y,Z).

determiner([the|Z],Z).
determiner([a|Z],Z).

noun([dog|Z],Z).
noun([cat|Z],Z).
noun([boy|Z],Z).
noun([girl|Z],Z).

verb([chased|Z],Z).
verb([saw|Z],Z).
verb([said|Z],Z).

