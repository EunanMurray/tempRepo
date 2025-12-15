% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

goal(at(Pos)) :- member(at(Pos),[at(1),at(2)]). % member of valid positions
goal(empty(1)).
goal(empty(2)).



action(suck,State,NewState) :-
    member(at(Loc),State),
    member(dirt(Loc),State),
    delete(State,dirt(Loc),DState),
    append([empty(Loc)],DState,NewState).

action(left,State,NewState) :-
   member(at(2),State),
   delete(State,at(2),Nowhere),
   append([at(1)],Nowhere,NewState).

action(right,State,NewState) :-
   member(at(1),State),
   delete(State,at(1),Nowhere),
   append([at(2)],Nowhere,NewState).

all_goals_reached([]).
all_goals_reached([Goal|OtherGoals]) :-
    goal(Goal),
    all_goals_reached(OtherGoals).

% solve([at(1),dirt(1),dirt(2)],P).
solve(State,Plan) :-
    solve(State,[],Path),
    !, reverse(Path,Plan),
    writeSolution(Plan).

solve(GoalState,Previous, [GoalState|Previous]) :-
   all_goals_reached(GoalState).
solve(CurrentState,PreviousStates,StateList) :-
    action(Action,CurrentState,NextState),
    \+member(NextState,PreviousStates), % Avoid cycling
    solve(NextState,[[Action,CurrentState]|PreviousStates],StateList).


writeSolution([]).
writeSolution([[Action|CurrentState]|NextState]) :-
    write(CurrentState), write('-->'),
     write(Action),
    nl,
    writeSolution(NextState).
