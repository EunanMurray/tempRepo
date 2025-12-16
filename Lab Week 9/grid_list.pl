% Grid Data Structure using Lists

% Format 1: [[Row,Col,Value],...]
build_grid_format1(N, Grid) :-
    findall([R,C,e], (between(1,N,R), between(1,N,C)), Grid).

% Format 2: [[Row,Col,[]],...]
build_grid_format2(N, Grid) :-
    findall([R,C,[]], (between(1,N,R), between(1,N,C)), Grid).

% Place item at specific location (Format 1)
place_item(Grid, Row, Col, Item, NewGrid) :-
    select([Row,Col,_], Grid, [Row,Col,Item], NewGrid).

% Place item at specific location (Format 2 - add to list)
place_item_list(Grid, Row, Col, Item, NewGrid) :-
    select([Row,Col,OldList], Grid, Temp, Grid),
    append(OldList, [Item], NewList),
    NewGrid = [[Row,Col,NewList]|Temp].

% Get value at location
get_cell(Grid, Row, Col, Value) :-
    member([Row,Col,Value], Grid).

% Print grid with formatting
print_grid(Grid) :-
    findall(R, (member([R,_,_], Grid)), AllRows),
    sort(AllRows, Rows),
    findall(C, (member([_,C,_], Grid)), AllCols),
    sort(AllCols, Cols),
    length(Cols, NumCols),
    print_header(NumCols),
    print_rows(Grid, Rows, Cols).

print_header(NumCols) :-
    format('~t~w~5|', ['']),
    forall(between(1,NumCols,C), format('~t~w~5|', [C])),
    nl.

print_rows(_, [], _).
print_rows(Grid, [R|Rs], Cols) :-
    format('~t~w~5|', [R]),
    print_row_cells(Grid, R, Cols),
    nl,
    print_rows(Grid, Rs, Cols).

print_row_cells(_, _, []).
print_row_cells(Grid, R, [C|Cs]) :-
    (get_cell(Grid, R, C, Value) ->
        format_value(Value, Str),
        format('~t~w~5|', [Str])
    ;
        format('~t~w~5|', [''])
    ),
    print_row_cells(Grid, R, Cs).

format_value(e, '.').
format_value([], '.').
format_value([H|T], Str) :-
    atomic_list_concat([H|T], ',', Str).
format_value(Val, Val) :- atomic(Val).

% Get adjacent cells (N, S, E, W)
adjacent(Grid, Row, Col, Adjacent) :-
    findall([R,C,V], (
        (R is Row-1, C = Col ; R is Row+1, C = Col ;
         R = Row, C is Col-1 ; R = Row, C is Col+1),
        member([R,C,V], Grid)
    ), Adjacent).

% Get adjacent with diagonals
adjacent_all(Grid, Row, Col, Adjacent) :-
    findall([R,C,V], (
        between(-1,1,DR), between(-1,1,DC),
        \+ (DR = 0, DC = 0),
        R is Row+DR, C is Col+DC,
        member([R,C,V], Grid)
    ), Adjacent).

% Example usage
test_grid :-
    build_grid_format1(5, Grid1),
    place_item(Grid1, 3, 3, x, Grid2),
    place_item(Grid2, 1, 1, a, Grid3),
    place_item(Grid3, 5, 5, z, Grid4),
    print_grid(Grid4).
