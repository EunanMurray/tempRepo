% Figure 22.3  A straightforward implementation of the minimax principle.


% minimax( Pos, BestSucc, Val):
%    Pos is a position, Val is its minimax value;
%    best move from Pos leads to position BestSucc
max_to_move( a).
max_to_move( d).
max_to_move( e).
max_to_move( f).
max_to_move( g).


min_to_move( b).
min_to_move( c).

min_to_move( i).
min_to_move( j).
min_to_move( k).
min_to_move( l).
min_to_move( m).
min_to_move( n).
min_to_move( o).
min_to_move( p).

staticval( i, 1).
staticval( j, 4).
staticval( k, 5).
staticval( l, 6).
staticval( m, 2).
staticval( n, 1).
staticval( o, 1).
staticval( p, 1).

moves( a, [b,c]).
moves( b, [d,e]).
moves( c, [f,g]).
moves( d, [i,j]).
moves( e, [k,l]).
moves( f, [m,n]).
moves( g, [o,p]).

minimax( Pos, BestSucc, Val)  :-
  moves( Pos, PosList), !,               % Legal moves in Pos produce PosList
  best( PosList, BestSucc, Val)
   ;
   staticval( Pos, Val).                 % Pos has no successors: evaluate statically 

best( [ Pos], Pos, Val)  :-
  minimax( Pos, _, Val), !.

best( [Pos1 | PosList], BestPos, BestVal)  :-
  minimax( Pos1, _, Val1),
  best( PosList, Pos2, Val2),
  betterof( Pos1, Val1, Pos2, Val2, BestPos, BestVal).

betterof( Pos0, Val0, _, Val1, Pos0, Val0)  :-        % Pos0 better than Pos1
  min_to_move( Pos0),                                    % MIN to move in Pos0
  Val0 > Val1, !                                         % MAX prefers the greater value
  ;
  max_to_move( Pos0),                                    % MAX to move in Pos0
  Val0 < Val1, !.                                % MIN prefers the lesser value 



betterof( _, _, Pos1, Val1, Pos1, Val1). % Otherwise Pos1 better
% than Pos0

