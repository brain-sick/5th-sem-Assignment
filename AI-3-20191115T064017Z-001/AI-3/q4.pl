

access_of_file(file, [person_1, person_2]).
access_of_file("audio.c", [david, chris, john]).
access_of_file("video.c", [david, chris, john]).


fileown(file, date_created, date_modified, owner).
fileown("audio.c", "01-01-2019", "03-10-2019", david).
fileown("video.c", "12-03-2019", "11-11-2019", john).



number_of_file(N, X) :-
    findall(Y, fileown(Y, _, _, X), Bag),
    length(Bag, N).


file_shared(F, X, Y) :-
    access_of_file(F, L),
    member(X, L),
    !,
    member(Y, L).



question(Q, A) :-
    Q = [when, did, N, change, the, file, F,?],
    fileown(F, _, X, N),
    A = [N, changed, F, on, X].


question(Q, A) :-
    Q = [does, N1, share, F, with, N2,?],
    file_shared(F, N1, N2),
    A = yes.



question(Q, A) :-
    Q = [how, many, files, does, X, own,?],
    number_of_file(N, X),
    A = [X, owns, N, files].

