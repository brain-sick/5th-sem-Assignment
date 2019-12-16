%manual_play(100).


won(Board, Player) :- win_byrow(Board, Player).
won(Board, Player) :- win_bycol(Board, Player).
won(Board, Player) :- win_bydiag(Board, Player).

win_byrow(Board, Player) :- Board = [Player,Player,Player,_,_,_,_,_,_].
win_byrow(Board, Player) :- Board = [_,_,_,Player,Player,Player,_,_,_].
win_byrow(Board, Player) :- Board = [_,_,_,_,_,_,Player,Player,Player].

win_bycol(Board, Player) :- Board = [Player,_,_,Player,_,_,Player,_,_].
win_bycol(Board, Player) :- Board = [_,Player,_,_,Player,_,_,Player,_].
win_bycol(Board, Player) :- Board = [_,_,Player,_,_,Player,_,_,Player].

win_bydiag(Board, Player) :- Board = [Player,_,_,_,Player,_,_,_,Player].
win_bydiag(Board, Player) :- Board = [_,_,Player,_,Player,_,Player,_,_].


other(x,o).
other(o,x).

game(Board, Player) :- won(Board, Player), !, write([player, Player, wins]).
game(Board, Player) :- 
  other(Player,Otherplayer), 
  next_move(Board,Player,Newboard),
  !,
  show_newstate(Newboard),
  game(Newboard,Otherplayer).

next_move([b,B,C,D,E,F,G,H,I], Player, [Player,B,C,D,E,F,G,H,I]).
next_move([A,b,C,D,E,F,G,H,I], Player, [A,Player,C,D,E,F,G,H,I]).
next_move([A,B,b,D,E,F,G,H,I], Player, [A,B,Player,D,E,F,G,H,I]).
next_move([A,B,C,b,E,F,G,H,I], Player, [A,B,C,Player,E,F,G,H,I]).
next_move([A,B,C,D,b,F,G,H,I], Player, [A,B,C,D,Player,F,G,H,I]).
next_move([A,B,C,D,E,b,G,H,I], Player, [A,B,C,D,E,Player,G,H,I]).
next_move([A,B,C,D,E,F,b,H,I], Player, [A,B,C,D,E,F,Player,H,I]).
next_move([A,B,C,D,E,F,G,b,I], Player, [A,B,C,D,E,F,G,Player,I]).
next_move([A,B,C,D,E,F,G,H,b], Player, [A,B,C,D,E,F,G,H,Player]).

show_newstate([A,B,C,D,E,F,G,H,I]) :- write([A,B,C]),nl,write([D,E,F]),nl,
 write([G,H,I]),nl,nl.

selfgame :- game([b,b,b,b,b,b,b,b,b],x).

% Predicates to support playing a game with the user:

 x_wins_in_one(Board) :- next_move(Board, x, Newboard), won(Newboard, x).


oppo_responses(Board,Newboard) :- 
  next_move(Board, o, Newboard),
  won(Newboard, o),
  !.
oppo_responses(Board,Newboard) :-
  next_move(Board, o, Newboard), 
  not(x_wins_in_one(Newboard)).
oppo_responses(Board,Newboard) :-
 next_move(Board, o, Newboard).
oppo_responses(Board,Newboard) :-
  not(member(b,Board)),
  !, 
  write('The game has drawn!'), nl,
  Newboard = Board.


move_ofx([b,B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
move_ofx([A,b,C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
move_ofx([A,B,b,D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
move_ofx([A,B,C,b,E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
move_ofx([A,B,C,D,b,F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
move_ofx([A,B,C,D,E,b,G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
move_ofx([A,B,C,D,E,F,b,H,I], 7, [A,B,C,D,E,F,x,H,I]).
move_ofx([A,B,C,D,E,F,G,b,I], 8, [A,B,C,D,E,F,G,x,I]).
move_ofx([A,B,C,D,E,F,G,H,b], 9, [A,B,C,D,E,F,G,H,x]).
move_ofx(Board, N, Board) :- write('your move is illegal.'), nl.


manual_play(Utility) :- explain, playingfrom([b,b,b,b,b,b,b,b,b],Utility).

explain :-
  write('you will play as x and enter integer position followed by a period.'),
  nl,
  show_newstate([1,2,3,4,5,6,7,8,9]).

playingfrom(Board,Utility) :- won(Board, x), write('You win! with utility value of '),write(Utility).
playingfrom(Board,Utility) :- won(Board, o), write('I win!'),write(' and Minimum Utility value came.').
playingfrom(Board,Utility) :- read(N),
  move_ofx(Board, N, Newboard), 
  show_newstate(Newboard),
  oppo_responses(Newboard, Newnewboard), 
  show_newstate(Newnewboard),
  playingfrom(Newnewboard,Utility).
