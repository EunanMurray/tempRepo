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

solveBestCostByG(Start,Sol) :-
    bestCost(Start,[[0,[Start]]],Sol).

bestCost(Node,[[Gcost,[Node|Path]]|_],[Gcost,[Node|Path]]) :-
    goal(Node).

bestCost(Node,[[Gcost,[Node|Path]]|Rest],Sol) :-
    /*
    findall([NewCost,[Successor,Node|Path]],
          ( s(Node,Successor,Cost),NewCost is Gcost + Cost),NewFringe),
          */

    bagof([NewCost,[Successor,Node|Path]],
          Successor^Cost^(s(Node,Successor,Cost),NewCost is Gcost +
          Cost),NewFringe),

    append(NewFringe,Rest,NewFrontier),
    sort(NewFrontier,[[NewGcost,[NewNode|PreviousNodes]]|Others]),
    display_frontier([[NewGcost,[NewNode|PreviousNodes]]|Others]),
    bestCost(NewNode,[[NewGcost,[NewNode|PreviousNodes]]|Others],Sol).

% Discard current top node as bagof has failed
bestCost(_,[_,[Gcost,[NextNode|Path]]|Rest],Sol) :-
    bestCost(NextNode,[[Gcost,[NextNode|Path]]|Rest],Sol).

display_frontier([]) :- nl.
display_frontier([H|T]) :-
    write(H),write(' '),
    display_frontier(T).
