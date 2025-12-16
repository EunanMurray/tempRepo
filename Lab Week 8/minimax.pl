% Figure 22.3  A straightforward implementation of the minimax principle.


% minimax( Pos, BestSucc, Val):
%    Pos is a position, Val is its minimax value;
%    best move from Pos leads to position BestSucc
max_to_move( root).
max_to_move( a11).
max_to_move( a12).
max_to_move( a13).
max_to_move( a21).
max_to_move( a22).
max_to_move( a23).
max_to_move( a31).
max_to_move( a32).
max_to_move( a33).

min_to_move( a1).
min_to_move( a2).
min_to_move( a3).

staticval( a11, 3).
staticval( a12, 12).
staticval( a13, 8).
staticval( a21, 2).
staticval( a22, 4).
staticval( a23, 6).
staticval( a31, 14).
staticval( a32, 5).
staticval( a33, 2).

moves( root, [a1, a2, a3]).
moves( a1, [a11, a12, a13]).
moves( a2, [a21, a22, a23]).
moves( a3, [a31, a32, a33]).

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

