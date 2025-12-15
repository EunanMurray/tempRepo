% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

sentence(sentence(NP,VP)) --> noun_phrase(NP),
                 verb_phrase(VP).

noun_phrase(np(Det,Noun)) --> determiner(Det),
                    noun(Noun).

verb_phrase(vp(V,NP)) --> verb(V),
                    noun_phrase(NP).

verb_phrase(vp(V,S)) --> verb(V),
                    sentence(S).

determiner(det(X)) --> [X],{member(X,[the,a])}.
determiner(det(blank)) --> [].

noun(noun(X)) --> [X],{member(X,[dogs,dog,cats,cat,boys,boy,girl,girls])}.

verb(verb(X)) --> [X],{member(X,[chase,chases,see,saw,said])}.