% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

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
    assertz(
    square(CurrentRow,CurrentCol,e)),
    NextCol is CurrentCol -1,
    createCol(CurrentRow,NextCol).
% Where e represents an empty square.

place(Piece,N) :-
    random_between(1,N,Row1),
    random_between(1,N,Col1),
    place(Piece,Row1,Col1).

place(Symbol,Row,Col) :-
    retract(square(Row,Col,e)),
    assertz(square(Row,Col,Symbol)).

clear_board :-
    retractall(square(_,_,_)),
    createBoard(3),
    listing(square/3).



test_win :-
    clear_board,
    createBoard(3),
    place(x,1,1), place(x,1,2),place(x,1,3),
    win(x).


win(S) :-

    setof([R,C,V],(square(R,C,V), V \== e),Occupied),
    win(Occupied,S).

rank([[1,1],[1,2],[1,3]]).

win(Board,S) :-
          member([1,1,S],Board),
          member([1,2,S],Board),
          member([1,3,S],Board).

