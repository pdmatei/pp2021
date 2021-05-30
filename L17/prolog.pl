/* V0 - program in PROLOG */

student(tim).
student(bob).
student(john).
student(mary).

/* 
   Exista prezenta o signatura? NU.

   student/1 <- aritate 1   este un predicat. (In sensul FOL/LP1).
   tim, bob, john, mary sunt atomi (predicate de aritate 0)

   Interpretor de PROLOG
   swi-prolog

   Efectuam interogari.

   Filozofie: CLOSED-WORLD ASSUMPTION.
   Tot ce nu e declarat explicit ca fiind adevarat, este fals.

   string-urile cu litera mare, reprezinta variabile.

   ?- student(X).   <- un scop, pe care prolog incearca sa il satisfaca.

*/

%male/1
male(tim).
male(bob).
male(john).

%female/1
female(mary).

%lecture/1
lecture(pp).
lecture(aa).

%studies/2
studies(tim,aa).
studies(mary,pp).
studies(mary,aa).
studies(john,pp).

/*
    ?- student(X), female(X).  

    query-ul codifica o propozitie din logica cu predicate de ordin I:

    student(X) ^ female(X)

*/

% maleStudent/1
maleStudent(X) :- male(X), student(X).
/*
 - definitie (de predicat)
 - clauza
 - regula

male(X) ^ student(X) => maleStudent(X)  (rezolvent)
A => B  ~A V B

~male(X) V ~student(X) V maleStudent(X)
O propozitie este o clauza horn, daca este o disjunctie in care CEL MULT
un literal este pozitiv.

Clauze Horn.
- ORICE PROGRAM PROLOG, este o lista de clauze horn.

*/

withMaleColeague(X) :- student(X),
                       female(X),
                       studies(X,L),
                       studies(Y,L),
                       student(Y),
                       male(Y).

twoStudentLecture(lfa).
twoStudentLecture(L) :- lecture(L), studies(X,L), studies(Y,L), X \= Y.


/* Cum scriem "COD" in sens conventional. 

Vom codifica NUMERE NATURALE.
Conventie:
   atomul     zero   va reprezenta numarul zero.
   predicatul succ/1 va reprezenta succesorul unui numar natural.

   zero             -  0
   succ(zero)       -  1
   succ(succ(zero)) -  2

   Expresia succ(succ(zero)) se numeste "Termen" (expresie)
   ea este formata, din:
      - predicatul succ/1
      - alt termen: succ(zero) 


Sa definim un predicat:
nat/1
care construieste TOATE numerele naturale.
*/

nat(zero).
nat(X) :- X = succ(Y), nat(Y).

/*
   Semnificatia lui =:
     - "=" nu inseamna ASSIGNMENT, si nici COMPARATIE
     - "=" inseamna unificare.

     expr1 = expr2

     t(e1, e2, ..., en) = t(e'1, e'2, ..., e'n)
       e1 = e'1
       e2 = e'2
       ...
       en = e'n

     succ(succ(zero)) = succ(Y)
     doar daca
     Y = succ(zero)

*/
%isZero/1
isZero(zero).
isZero(succ(_)) :- fail.


/*
Cum facem calcule:
  input -> output

predicat(I1, I2 , In, O1, ... Om)
  - I1 ... In - reprezinta variabile care sa fie legate (la date).
  - la inceput, O1, ... Om  NU sunt instantiate.

  - dupa ce predicatul este satisfacut, ACELE variabile O, vor fi legate la rezultat.
*/

%fromNat/2
%fromNat(I,O)  I - reprezinta un numar de forma zero/succ(?)
%              O - o variabila initial neinstantiata, care va fi legata la un Integer, dupa ce predicatul fromNat, va fi satisfacut.

fromNat(zero,0).
fromNat(succ(Y),O) :- fromNat(Y,R), O is R + 1.

% scopul O is R + 1, este assignment (in prolog merge doar pe intregi )

%toNat/2
%toNat(X,Y) X este un intreg, Y trebuie sa fie echivalentul lui, reprezentat cu zero si succ/1


% O is succ(R).
% V is expr   - V trebuie sa fie o variabila neinstantiata, 
%             - expr trebuie sa fie o expresie aritmetica

% toNat(1 + I, O) :- toNat(I, R), O is succ(R).

toNat(0,zero).
toNat(X,succ(Rp)) :- X > 0, Xp is X - 1, toNat(Xp,Rp).


