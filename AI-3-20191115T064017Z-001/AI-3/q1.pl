%route(a,d,[a],[a],0,50,0.5,50,0.6,0.8)
road(a,b,10,1,3).
road(b,a,10,1,3).
road(b,c,17,8,4).
road(c,b,17,8,4).
road(c,d,12,10,3).
road(d,c,12,10,3).
road(d,b,15,2,9).
road(b,d,15,2,9).


printK([]).
printK([H|L]):-printK(L), write(H).

append([], Y, Y).
append([H|X], Y, [H|Z]):- append(X, Y, Z).
   
route(A,A,L,Tlist,Cost,Fcurrent,Mil,Finitial,Wtraffic,Wroad):-
    printK(L),
    nl,
    write(Cost),
    nl,
    fail.
	
route(A,B,L,Tlist,Cost,Fcurrent,Mil,Finitial,Wtraffic,Wroad):-
    road(A,X,Dist,Traffic,Rc),
    not(member(X,Tlist)),
    ReqFuel is Dist/Mil,
    Finitial >= ReqFuel,
    Cost2 is Cost+Dist+ Wtraffic*Traffic + Wroad*Rc,
    Frem is Fcurrent - ReqFuel,
    (
        Frem < 0 ->
        append([" Refuel-> "],L,L1),
        Fcurrent1 is Finitial - ReqFuel,
        route(X,B,[X|L1],[X|Tlist],Cost2,Fcurrent1,Mil,Finitial,Wtraffic,Wroad)
        ; 
        append(["->"],L,L1),
        route(X,B,[X|L1],[X|Tlist],Cost2,Frem,Mil,Finitial,Wtraffic,Wroad)
    ).
