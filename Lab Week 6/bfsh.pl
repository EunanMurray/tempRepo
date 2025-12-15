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

solveBestCostByH(Start,Sol) :-
    bestCostHeuristic(Start,[[0,[Start]]],Sol).


bestCostHeuristic(Node,[[Hcost,[Node|Path]]|_],[Hcost,[Node|Path]]) :-
    goal(Node).

bestCostHeuristic(Node,[[_,[Node|Path]]|Rest],Sol) :-
    findall([NewCost,[Successor,Node|Path]],
          (   s(Node,Successor,_),h(Successor,NewCost)),NewFringe),
    append(NewFringe,Rest,NewFrontier),
    sort(NewFrontier,[[NewHcost,[NewNode|PreviousNodes]]|Others]),
    display_frontier([[NewHcost,[NewNode|PreviousNodes]]|Others]),
    bestCostHeuristic(NewNode,[[NewHcost,[NewNode|PreviousNodes]]|Others],Sol).

display_frontier([]) :- nl.
display_frontier([H|T]) :-
    write(H),write(' '),
    display_frontier(T).
