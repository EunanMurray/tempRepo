% square(row,col,val)
:- dynamic square/3.
createBoard(N) :-
	createBoard(N,N).
createBoard(0,_).
createBoard(Row,Col) :-
    createCol(Row,Col),
    NextRow is Row -1,
    createBoard(NextRow,Col).

createCol(Row,1) :-
    assertz(square(Row,1,e)).

createCol(CurrentRow,CurrentCol) :-
    assertz(square(CurrentRow,CurrentCol,e)),
    NextCol is CurrentCol -1,
    createCol(CurrentRow,NextCol).

place(Piece,N) :-
	repeat,
    Row1 is random(N),
    Col1 is random(N),
    place(Piece,Row1,Col1).

    

place(Symbol,Row,Col) :-
	retract(square(Row,Col,e)),
	assertz(square(Row,Col,Symbol)).

test_place(R,C,Symbol) :-
    createBoard(3),
    place(Symbol,3),
    setof([R,C,V],square(R,C,V),Board),
    write(Board).

test_place_all(L) :-
    createBoard(3),
    place_list(L,3),
    setof([R,C,V],square(R,C,V),Board),
    write(Board).

place_list([],_).

place_list([Item|Rest],N) :-
    bagof([R,C],square(R,C,e),_L),
    place(Item,N),
    place_list(Rest,N).

test_max(M) :-
    createBoard(3),
	max(M).    

max(M) :-
    setof(R,square(R,_C,_V),Rows),
    reverse(Rows,[M|_]).

test_adjcent(R,C) :-
    createBoard(3),
	all_adjacent(R,C,All),
    writeln(All).


all_adjacent_item(R,C,All) :-
    setof([Ar,Ac,V,D],
          (adjacent(R,C,Ar,Ac,D),
              square(Ar,Ac,V)),
          All).

test_at_place(Item,D) :-
	createBoard(3),
    place(Item,1,2),
    place(Item,3,2),    
    all_adjacent_item(2,2,All),
    member([_Ar,_Ac,Item,D],All).
    

all_adjacent(R,C,All) :-
    setof([Ar,Ac,D],
          adjacent(R,C,Ar,Ac,D),
          All).

adjacent(R,C,Ar,C,north) :-
    Ar is R -1,
    Ar > 0.

adjacent(R,C,Ar,C,south) :-
	max(M),
    Ar is R +1,
    Ar =< M.

adjacent(R,C,R,Ac,east) :-
	max(M),
    Ac is C +1,
    Ac =< M.
adjacent(R,C,R,Ac,west) :-
    Ac is C - 1,
    Ac > 0.



