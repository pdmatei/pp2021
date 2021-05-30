/*

o reprezentare pt. numere naturale.
zero
succ

2 - succ(succ(zero)).

*/

nat(zero).
nat(succ(Y)) :- nat(Y).

% fromNat/2 
% fromNat(N,I).  N - un numar natural (o variabila instantiata)
%                dupa ce fromNat va fi satisfacut, I va fi reprezentarea integer a lui N
fromNat(zero,0).
fromNat(succ(X),I) :- fromNat(X,Ip), I is Ip + 1.

toNat(0,zero).
toNat(I,succ(N)) :- I > 0, Ip is I - 1, toNat(Ip,N).

/*

O definitie pentru liste.

void - codifica lista vida
cons/2 - va codifica o lista nevida.

cons(1,cons(2,cons(3,void))) - un termen.

*/

%head/2
head(cons(H,_),H).
%tail/2
tail(cons(_,T),T).


%append concatenarea a doua liste.
%append/3
% append(L1,L2,R) unde L1, L2 sunt liste instantiate. Iar R va fi rezultatul concatenarii lui L1 cu L2.
%                      
append1(void,L2,L2).
append1(cons(H,T), L2, cons(H,R)) :- append1(T,L2,R).


/*
   Reprezentarea standard a listelor in Prolog.
   - Exact ca a noastra - dpdv conceptual.

   void      - []
   cons(H,T) - [H|T]

   Abrevieri:
   [X]       - [X|[]]
   [X,Y,Z]   - [X|[Y|[Z|[]]]]
   [H1,H2,H3|T] - [H1|[H2|[H3|T]]]

 ******************************
 Expresii aritmetice in Prolog
 ******************************

 add(X,Y)    add(Y,X)
 X + Y unif. Y + X,      X * Y unif. 2 * Y.
  X unif. Y              X unif. 2    
  Y unif. X              Y unif. Y

 member/2
 member(X,L) verifica daca X apartine listei L.
 X si L trebuie sa fie instantiate.


*/

member1(X, [X|_]).
member1(X, [_|L]) :- member1(X, L).

%member2(X, [X|_]).
%member2(X, [Y|L]) :- X \= Y, member2(X,L).

%twoDistinct/1 o lista are macar doua elemente diferite.
twoDistinct(L) :- member(X,L), member(Y,L), X \= Y.

%un predicat care verifica daca o lista se termina cu elementul 3:
last(L) :- append(_,[3],L).

%un predicat care genereaza toate sufixele unei liste:
/*
    ?- suffix([1,2,3,4,5,6],S).
    S = [2,3,4,5,6];
    S = [3,4,5,6];
    S = [4,5,6];
    S = [5,6];
    S = [6];
    S = []

*/
%suffix/2  suffix(L,S).
suffix(L,S) :- append(_,S,L).

% generam subliste
% sublist/2

/*
 L = _ ++ P ++ _

*/
sublist(L,P) :- append(_,P,Res), append(Res,_,L).
/*
sublist([1,2,3],P)
append(X,P,Res)    - nici o variabila nu este instantiata.

[],[],[]
...
[A,B],[C], [A,B,C]
append([A,B,C],_,[1,2,3])

la un moment dat:

[A,B] [C,D] [A,B,C,D]

append([A,B,C,D],_,[1,2,3])
false.

*/
sublist2(L,Middle) :- append(_,Suffix,L),   % L = _ ++ Suffix
                      append(Middle,_,Suffix). % Suffix = Middle ++ _






