/*
    
    Bottles = [2,3,5,1,4]

    profit(Bottles,Year,Pr)
      variabilele Bottles si Year trebuie sa fie instantiate.

*/
profit([],_,0).
profit(L,Y,Pr) :- L = [Fst|Rest], Yp is Y + 1, profit(Rest,Yp,PrLeft),
                  append(Pref,[Last],L), profit(Pref,Yp,PrRight),
                  Pr is max(Fst * Y + PrLeft, Last * Y + PrRight).

test(R) :- profit([2,3,5,1,4,6,7,1,2,3,5,3,4,7,1,2,3,4,5,6,7,5,3],1,R).

/*
   Cum putem impiedica resatisfacerea?

*/
%grade(Id,Lecture,Grade) 
grade(9,pp,6).
grade(10,aa,4).
grade(11,lfa,10).

/* 
    "curs in care toti studentii au promovat" 
    
    In FOL:  forall G. grade(_,L,G), G >= 5.

    Transformand in negatie:
             ~exists G. grade(_,L,G), G < 5.


*/
%g(X) :- p(X), q(X), !, r(X), s(X).


allPassed(L) :- grade(_,L,G), G < 5, !, fail.
allPassed(_).                              %daca nu exista o nota <5, atunci - allPassed(L) satisface.


/* Discutam despre un operator de limitare a re-satisfacerii
   ! (cut)
     Semantica pentru scopul ! (cut):
        - cut va fi satisfacut pur si simplu, atunci cand e intalnit prima oara.
        - cut va esua PERMANENT, atunci cand se incearca REsatisfacerea lui.

*/

not(G) :- G,!,fail.
not(_).

% CLOSED-WORLD ASSUMPTION: not(G), inseamna ca G nu se poate satisface.

% not(X = Y)

allPassed2(L) :- not((grade(_,L,G), G < 5)).

/*
% V = [1,2,3,4,5]
% E = [[1,2], [1,3], [2,3], [3,4]]
% G = [ [1,2,3,4,5], [[1,5], [1,2], [1,3], [2,3], [3,4]]]


       1 ------ 5
      |  \
      |   \
      2 -- 3 -- 4 

*/
graph([ [1,2,3,4,5], [[1,5], [1,2], [1,3], [2,3], [3,4]]]).

edge(X,Y,[_,E]) :- member([X,Y],E).
edge(X,Y,[_,E]) :- member([Y,X],E).



connected(X,Y,G,[X,Y],Visited) :- not(member(Y,Visited)), edge(X,Y,G).
connected(X,Y,G,[X|Path],Visited) :- edge(X,Z,G), not(member(Z,Visited)), connected(Z,Y,G,Path,[Z|Visited]).


/*
   X ........... Y
   X - Z ....... Y


Cum generam submultimi dintr-o multime de noduri.

subset1/2

subset1(L,R)
 - L este o lista oarecare
 - R va fi o submultime a listei L


*/
subset1([],[]).
subset1([H|T],[H|R]) :- subset1(T,R).
subset1([_|T],R) :- subset1(T,R).


subsetk(_,0,[]) :- !.
subsetk(L,K,[X|Rp]) :- Kp is K - 1, subsetk(L,Kp,Rp), member(X,L), not(member(X,Rp)).


kvc(C,K,[V,E]) :- subsetk(C,K,V), coverCondition(C,[V,E]).
coverCondition(C,E) :- not(edge(X,Y,[V,E]), not(covered(X,Y,C))).
covered(X,_,C) :- member(X,C).
covered(_,Y,C) :- member(Y,C).


kvcp(C,K,[V,E]) :- subsetk(C,K,V), not(edge(X,Y,[V,E]), not((member(X,C) ; member(Y,C)))).










