married(george,mum).
married(spencer,kydd).
married(elizabeth,philip).
married(diana,charles).
married(anne,mark).
married(andrew,sarah).
married(edward,sophie).
male(george).
male(spencer). 
male(philip).
male(charles). 
male(mark). 
male(andrew). 
male(edward). 
male(william).
male(harry).
male(peter).
male(james). 
female(mum).
female(kydd).
female(elizabeth).
female(margaret).
female(diana).
female(anne).
female(sarah).
female(sophie).
female(zara).
female(beatrice).
female(louise).
female(eugenie). 
parent(mum,elizabeth).
parent(george,elizabeth).
parent(mum,margaret).
parent(george,margaret).
parent(kydd,diana).
parent(spencer,diana).
parent(elizabeth,charles).
parent(philip,charles).
parent(elizabeth,anne).
parent(philip,anne).
parent(elizabeth,andrew).
parent(philip,andrew).
parent(elizabeth,edward).
parent(philip,edward).
parent(diana,william).
parent(charles,william).
parent(diana,harry).
parent(charles,harry).
parent(anne,peter).
parent(mark,peter).
parent(anne,zara).
parent(mark,zara).
parent(sarah,beatrice).
parent(andrew,beatrice).
parent(sarah,eugenie).
parent(andrew,eugenie).
parent(sophie,louise).
parent(edward,louise).
parent(sophie,james).
parent(edward,james).


greatgrandparent(A,B) :- grandparent(C,B), parent(A,C).

grandparent(A,B) :- parent(C,B), parent(A,C).

ancestor(A,B) :- parent(A,B).
ancestor(A,B) :- parent(A,C), ancestor(C,B).

grandchild(A,B) :- grandparent(B,A).

sibling(A,B) :- male(C), parent(C,A), parent(C,B), A\=B.

brother(A,B) :- sibling(A,B), male(A).

sister(A,B) :- sibling(A,B), female(A).

daughter(A,B) :- parent(B,A), female(A).

son(A,B) :- parent(B,A), male(A).

firstcousin(A,B) :- grandparent(C,A), grandparent(C,B).

brotherinlaw1gen(A,B) :- male(A), spouse(C,B), sibling(A,C).
brotherinlaw1gen(A,B) :- male(A), spouse(B,C), sibling(A,C).

sisterinlaw1gen(A,B) :- female(A), spouse(C,B), sibling(A,C).
sisterinlaw1gen(A,B) :- female(A), spouse(B,C), sibling(A,C).

brotherinlaw2gen(A,B) :- brotherinlaw1gen(A,B).
brotherinlaw2gen(A,B) :- sisterinlaw1gen(C,B), spouse(A,C).

sisterinlaw2gen(A,B) :- sisterinlaw1gen(A,B).
sisterinlaw2gen(A,B) :- brotherinlaw1gen(C,B), spouse(A,C).

aunt(A,B) :- parent(C,B), sibling(A,C), female(A).

uncle(A,B) :- parent(C,B), sibling(A,C), male(A).

spouse(A,B) :- married(A,B).
spouse(A,B) :- married(B,A).

#swipl family.pl
#findall(A, brother(A, charles), B).
#findall(A, brotherinlaw2gen(A, diana), B).
#findall(A, son(A, sophie), B).
#findall(A, grandchild(A, elizabeth), B).