
:- dynamic has_part/2, isa/2.

has_part(report,[author(_A),topic(_T),dday(_D),length(_L)]).
has_part(progress_report,[author(project_leader(T,_A)),
				topic(T),dday(_D),length(2)]).
has_part(technical_report,[author(project_leader(T,_A)),
				topic(T),dday(_D),length(30)]).

isa(progress_report,report).
isa(technical_report,report).



frame_test :-
	retractall(has_part(progress_reportNo15,_Slots)),
	retractall(isa(progress_reportNo15,_Report)),
	make_frame(progress_report,progress_reportNo15,'Biological Classification Project'),
	listing(has_part/2),
	listing(isa/2).

make_frame(Ftype,Fname,Topic) :-
	fill_frame(Ftype,Fname,Author,Topic,DueDate,Length),
%	concat(Ftype,Fname,Frame_name),
	assertz(isa(Fname,Ftype)),
	assertz(has_part(Fname,[Author,Topic,DueDate,Length])).


fill_frame(Frame_Type,Frame_Name,Author,Topic,DueDate,Length) :-
	nonvar(Frame_Type),
	nonvar(Frame_Name),
	nonvar(Topic),
	var(Author),project_leader(Topic,Author),
	var(DueDate),getDefaultDueDate(DueDate),
	var(Length),getDefaultLength(Frame_Type,Length),
	notify(Author,Topic,DueDate,Length).


fill_frame(_,_,_,_,_,_) :-
	write('Report must have a name, type and topic').

project_leader('Biological Classification Project','Mary Smith').

notify(A,T,D,L) :-
	write('Dear '),write(A),nl,
	tab(10),write('A report on  '),write(T),write(' is due from you '),nl,
	write(' by '),write(D),write('. Length is '),write(L),write(' pages. '),nl,
	get0(_).



getDefaultLength(_,Length) :-
	has_part(progress_report,[_,_,_,length(Length)]).

getDefaultDueDate(DueDate) :-
	get_time(Stamp),
	stamp_date_time(Stamp, DateTime, local),
	date_time_value(month, DateTime, MM),
	% date(_YYYY,MM,_DD,_Min,_Sec,_Off,_TZ,_DST),
	MM =< 4,
	DueDate = 'June 30'.

getDefaultDueDate(DueDate) :-
	get_time(Stamp),
	stamp_date_time(Stamp, DateTime, local),
	date_time_value(month, DateTime, MM),
	MM > 4 ,
	DueDate = 'Sept. 30'.
