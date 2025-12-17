:- op(1150, xfx, <- ).
:- op(950,xfy, &).

prove(true).
prove((A & B)) :-
   prove(A),
   prove(B).
prove(H) :-
   (H <- B),
   prove(B).