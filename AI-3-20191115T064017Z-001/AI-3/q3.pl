s(S0,S) :- np(S0,S1), vp(S1,S). 
is_name(X) :- member(X,["fred","mary","john"]).
is_n(X) :- member(X,["was","have","?","been","by","to"]).
is_tv(X) :- member(X,["told","seen","saw","see","believed"]).
is_v(X) :- member(X,["walks"]).
vp(S0,S) :- tv(S0,S1), np(S1,S).
vp(S0,S) :- v(S0,S).
vp(S0,S) :- v(S0,S1),vp(S1,S).

np(S0,S) :- det(S0,S1), n(S1,S2),np(S2,S).
np(S0,S) :- det(S0,S1),n(S1,S2),vp(S2,S).
np(S0,S) :- det(S0,S1),n(S1,S).
np(S0,S) :- n(S0,S1),np(S1,S).
np(S0,S) :- n(S0,S1),vp(S1,S).
np(S0,S) :- n(S0,S).
np(S0,S) :- det(S0,S1),vp(S1,S).
np(S0,S) :- det(S0,S).
np(S0,S) :- n(S0,S1),vp(S1,S).

det(S0,S) :- S0=[H|S],is_name(H).
    
n(S0,S) :- S0=[H|S],is_n(H).

tv(S0,S) :- S0=[H|S],is_tv(H).

v(S0,S) :- S0=[H|S],is_v(H).
