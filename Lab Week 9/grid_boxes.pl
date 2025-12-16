:- use_module(library(pce)).

% Create a window
create_window(Window) :-
    new(Window, picture('Text Grid Example')),
    send(Window, size, size(400, 400)),
    send(Window, open).

% Draw a grid using boxes with text
draw_grid(Window, Rows, Cols) :-
    Width is 400,
    Height is 400,
    BoxWidth is Width / Cols,
    BoxHeight is Height / Rows,
    draw_boxes(Window, Rows, Cols, BoxWidth, BoxHeight).

% Draw a grid from list structure [[R,C,Value],...]
draw_grid_from_list(Window, GridList) :-
    findall(R, member([R,_,_], GridList), AllRows),
    findall(C, member([_,C,_], GridList), AllCols),
    max_list(AllRows, MaxR),
    max_list(AllCols, MaxC),
    Width is 400,
    Height is 400,
    BoxWidth is Width / MaxC,
    BoxHeight is Height / MaxR,
    draw_grid_cells(Window, GridList, MaxR, MaxC, BoxWidth, BoxHeight).

% Draw boxes for the grid
draw_boxes(_, 0, _, _, _) :- !.
draw_boxes(Window, Rows, Cols, BoxWidth, BoxHeight) :-
    draw_row(Window, Rows, Cols, BoxWidth, BoxHeight),
    NewRows is Rows - 1,
    draw_boxes(Window, NewRows, Cols, BoxWidth, BoxHeight).

% Draw a row of boxes
draw_row(_, _, 0, _, _) :- !.
draw_row(Window, Row, Cols, BoxWidth, BoxHeight) :-
    X is BoxWidth * (Cols - 1),
    Y is BoxHeight * (Row - 1),
    random_color(Color),
    send(Window, display, new(Box, box(BoxWidth, BoxHeight)), point(X, Y)),
    send(Box, fill_pattern, colour(Color)),
    format(atom(Text), 'R~dC~d', [Row, Cols]),
    send(Window, display, new(Label, text(Text)), point(X + BoxWidth / 2, Y + BoxHeight / 2)),
    send(Label, center, point(X + BoxWidth / 2, Y + BoxHeight / 2)),
    NewCols is Cols - 1,
    draw_row(Window, Row, NewCols, BoxWidth, BoxHeight).

% Generate a random color
random_color(Color) :-
    Colors = [red, green, blue, yellow, cyan, magenta, orange, purple],
    random_member(Color, Colors).

% Add a button below the grid
add_button(Window) :-
    send(Window, display, new(_Button, button('Click Me', message(@prolog, button_action))), point(150, 410)).

% Define the button action
button_action :-
    send(@display, inform, 'Button clicked!').

% Draw all cells from grid list
draw_grid_cells(_, _, 0, _, _, _) :- !.
draw_grid_cells(Window, GridList, Row, Cols, BoxWidth, BoxHeight) :-
    draw_grid_row(Window, GridList, Row, Cols, BoxWidth, BoxHeight),
    NextRow is Row - 1,
    draw_grid_cells(Window, GridList, NextRow, Cols, BoxWidth, BoxHeight).

draw_grid_row(_, _, _, 0, _, _) :- !.
draw_grid_row(Window, GridList, Row, Col, BoxWidth, BoxHeight) :-
    X is BoxWidth * (Col - 1),
    Y is BoxHeight * (Row - 1),
    (member([Row,Col,Value], GridList) ->
        format_cell_value(Value, DisplayValue)
    ;
        DisplayValue = ''
    ),
    send(Window, display, new(Box, box(BoxWidth, BoxHeight)), point(X, Y)),
    send(Box, fill_pattern, colour(white)),
    format(atom(Text), '~w', [DisplayValue]),
    send(Window, display, new(Label, text(Text)), point(X + BoxWidth / 2, Y + BoxHeight / 2)),
    send(Label, center, point(X + BoxWidth / 2, Y + BoxHeight / 2)),
    NextCol is Col - 1,
    draw_grid_row(Window, GridList, Row, NextCol, BoxWidth, BoxHeight).

format_cell_value(e, '.').
format_cell_value([], '.').
format_cell_value(Value, Value).

% Main predicate to create and draw the grid
run :-
    create_window(Window),
    draw_grid(Window, 5, 5),
    add_button(Window).

% Test with list-based grid
run_list :-
    create_window(Window),
    Grid = [[1,1,a],[1,2,b],[1,3,c],[2,1,d],[2,2,x],[2,3,e],[3,1,g],[3,2,h],[3,3,z]],
    draw_grid_from_list(Window, Grid),
    add_button(Window).
