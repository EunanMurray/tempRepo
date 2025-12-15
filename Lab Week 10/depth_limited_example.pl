% `<-' is the object-level `if' - it is an infix meta-level predicate
:- op(1150, xfx, <- ).

% `&' is the object level conjunction.
% It is an infix meta-level binary function symbol:
:- op(950,xfy, &).

% bprove(G,D) is true if G can be proven with depth no more than D
dprove(true,_D).
dprove((A & B),D) :-
   dprove(A,D),
   dprove(B,D).
dprove(H,D) :-
   D >= 0,
   D1 is D-1,
   (H <- B),
   format('solving for (~w <- ~w) at depth ~w ~n',[H,B,D1]),
    dprove(B,D1).

:- op(1150, xfx, <- ).
:- op(950,xfy, &).

lit(L) <-
   light(L) &
   ok(L) &
   live(L).

live(W) <-
   connectedto(W,W1) &
   live(W1).

s(a,b) <- s(b,d).
s(a,c) <- true.
s(a,x) <- s(x,g).
s(x,g) <- true.
s(b,d) <- s(d,g).
s(d,g) <- true.
goal(d,g) <- true.
goal(x,g) <- true.


% If we are at the goal node and it is true
solve(N,Goal,Path,[Goal|Path]) <- goal(N,Goal).
% get the successor and see if it is the goal node
solve(Node1,Node3,Path,Final) <-
	s(Node1,Node2) &
	solve(Node2,Node3,[Node2|Path],Final).

