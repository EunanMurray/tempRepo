% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

arc(sligo,roscommon,85).
arc(sligo,galway,138).
arc(galway,roscommon,82).
arc(galway,athlone,93).
arc(galway,limerick,105).
arc(galway,shannon,92).
arc(roscommon,athlone,33).
arc(roscommon,portlaoise,106).
arc(athlone,portlaoise,74).
arc(athlone,limerick,121).
arc(shannon,limerick,24).




h(sligo,roscommon,75).
h(sligo,galway,125).
h(sligo,portlaoise,170).
h(roscommon,portlaoise,96).
h(galway,portlaoise,150).
h(galway,athlone,85).
h(athlone,portlaoise,70).
h(limerick,portlaoise,180).
h(shannon,portlaoise,190).
h(shannon,limerick,18).
h(portlaoise,portlaoise,0).

solve(Start,Goal,PathGoal) :-
	astar(Goal,[ [0,0,[Start]] ],PathGoal).


goal(portlaoise).
astar(Goal,[ [Fcost,Gcost,[Goal|Path]]|_],[Fcost,Gcost,[Goal|Path]]) :-
	goal(Goal).

astar(Goal,[ [TotalF,TotalG,[Current|Path]]|Rest],Sol) :-
	bagof([GCost,SuccessorH],
	      arc(Current,SuccessorH,GCost),FrontGs),
	getH(FrontGs,Goal,FrontHs),
	f(FrontGs,FrontHs,TotalG,Fs),
	add_frontier(Fs,[[TotalF,TotalG,[Current|Path]]|Rest],NewState),
	sort(NewState,SortedStates),
	astar(Goal,SortedStates,Sol).

% Bagof fails no successor so discard top node and continue with the rest
astar(Goal,[_|Rest],Sol) :-
	astar(Goal,Rest,Sol).

getH([],_,[]).
getH([[_,Node]|Rest],G,[[H,Node]|OtherHs]) :-
	h(Node,G,H),
	getH(Rest,G,OtherHs).

f([],[],_,[]).
f([[Gcost,Node]|Grest],[[Hcost,Node]|Hrest],G,[[Fcost,Node,TotalG]|RestF]) :-
	TotalG is  Gcost + G,
	Fcost is TotalG + Hcost,
	f(Grest,Hrest,G,RestF).

add_frontier([],[[_,_,[_|_]]|Rest],Rest).
add_frontier([[NewF,N,NewG]|FRest],
	     [[TotalF,TotalG,[Current|Path]]|Rest],[[NewF,NewG,[N,Current|Path]]|Last])
	     :-
	     add_frontier(FRest,[[TotalF,TotalG,[Current|Path]]|Rest],Last).








