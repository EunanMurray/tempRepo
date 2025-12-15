% Figure 22.5  An implementation of the alpha-beta algorithm.
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

% The alpha-beta algorithm

solve(Start,BestMove,BestValue) :-
    % we choose as the Alpha value the maximum static val that we can achieve + inifinity
    setof(V,Terminal^staticval(Terminal,V),[Beta|R]),
    % we choose as the Beta value the minimum static val that we can achieve + inifinity
    reverse([Beta|R],[Alpha|_]),
    alphabeta(Start,Alpha,Beta,BestMove,BestValue).


alphabeta( Pos, Alpha, Beta, GoodPos, Val)  :-
  moves( Pos, PosList), !,
  boundedbest( PosList, Alpha, Beta, GoodPos, Val);
  (   staticval( Pos, Val),
  write(staticval( Pos, Val)),nl).                              % Static value of Pos

boundedbest( [Pos | PosList], Alpha, Beta, GoodPos, GoodVal)  :-
  writef('Before: %w\t%w\t%w\t%w\t%w\t%w\n',[Pos,PosList,Alpha,Beta,GoodPos,GoodVal]),
  alphabeta( Pos, Alpha, Beta, _, Val),
  goodenough( PosList, Alpha, Beta, Pos, Val, GoodPos, GoodVal),
  writef('After : %w\t%w\t%w\t%w\t%w\t%w\n',[Pos,PosList,Alpha,Beta,GoodPos,GoodVal]).


goodenough( [], _, _, Pos, Val, Pos, Val)  :-  !.    % No other candidate

goodenough( _, Alpha, Beta, Pos, Val, Pos, Val)  :-
  min_to_move( Pos), Val > Beta, !                   % Maximizer attained upper bound
  ;
  max_to_move( Pos), Val < Alpha, !.                 % Minimizer attained lower bound

goodenough( PosList, Alpha, Beta, Pos, Val, GoodPos, GoodVal)  :-
  newbounds( Alpha, Beta, Pos, Val, NewAlpha, NewBeta),    % Refine bounds
  boundedbest( PosList, NewAlpha, NewBeta, Pos1, Val1),
  betterof( Pos, Val, Pos1, Val1, GoodPos, GoodVal).


newbounds( Alpha, Beta, Pos, Val, Val, Beta)  :-
  min_to_move( Pos), Val > Alpha, !.                 % Maximizer increased lower bound

newbounds( Alpha, Beta, Pos, Val, Val,Alpha)  :-
   max_to_move( Pos), Val < Beta, !.                 % Minimizer decreased upper bound

newbounds( Alpha, Beta, _, _, Alpha, Beta).          % Otherwise bounds unchanged

betterof( Pos, Val, _, Val1, Pos, Val)  :-        % Pos better than Pos1
  min_to_move( Pos), Val > Val1, !
  ;
  max_to_move( Pos), Val < Val1, !.

betterof( _, _, Pos1, Val1, Pos1, Val1).             % Otherwise Pos1 better
