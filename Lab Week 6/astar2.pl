
s(a,b,2).
s(a,c,1).
s(b,e,4).
s(b,g,5).
s(e,g,1).
s(c,d,1).
s(c,x,3).
s(x,g,1).


h(b,5).
h(c,2).
h(d,1).
h(e,4).
h(x,2).
h(g,0).

goal(g).


astar(Node,[[Fcost,Gcost,[Node|Path]]|_],[Fcost,Gcost,[Node|Path]]) :-
    goal(Node).

astar(Node,[[_OldFcost,Gcost,[Node|Path]]|Rest],Sol) :-
    findall([NewFcost,NewGcost,[Successor,Node|Path]],
          (   s(Node,Successor,Cost),h(Successor,H),
              NewGcost is Cost + Gcost,
              NewFcost is NewGcost + H),NewFringe),
    append(NewFringe,Rest,NewFrontier),
    sort(NewFrontier,[[NewFCost,NewGcost,[NewNode|PreviousNodes]]|Others]),
    display_frontier([[NewFCost,NewGcost,[NewNode|PreviousNodes]]|Others]),
    astar(NewNode,[[NewFCost,NewGcost,[NewNode|PreviousNodes]]|Others],Sol).

display_frontier([]) :- nl.
display_frontier([H|T]) :-
    write(H),write(' '),
    display_frontier(T).
