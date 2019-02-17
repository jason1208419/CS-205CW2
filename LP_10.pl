%group 10
%Kin Wah Lee 689591
%Chun Man Kwok 689613
%Shun Hei Lai 689916

% Program: ROYAL
parent(queenmother,elisabeth). parent(elisabeth,charles).
parent(elisabeth,andrew). parent(elisabeth,anne).
parent(elisabeth,edward). parent(diana,william).
parent(diana,harry). parent(sarah,beatrice).
parent(anne,peter). parent(anne,zara).
parent(george,elisabeth). parent(philip,charles).
parent(philip,andrew). parent(philip,edward).
parent(charles,william). parent(charles,harry).
parent(andrew,beatrice). parent(andrew,eugenie).
parent(mark,peter). parent(mark,zara).
parent(william,georgejun). parent(kate,georgejun).
parent(kate,charlotte).

%1(a)(1)
%true if a list of all female of the Royal Family inputed
the_royal_females([queenmother,elisabeth,anne,diana,sarah,beatrice,zara,eugenie,kate,charlotte]).

%1(a)(2)
%true if a list of all male of the Royal Family inputed
the_royal_males([charles,andrew,edward,william,harry,peter,george,philip,mark,georgejun]).

%1(a)(3)
%true if a list of all members of the Royal Family inputed
the_royal_family(Z):- the_royal_females(X),the_royal_males(Y),append(X,Y,Z).

%1(a)(4)
%X is the mother of Y
mother(X,Y):- the_royal_females(Z),member(X,Z),parent(X,Y).

%1(a)(5)
%X has child
has_child(X):- parent(X,_).

%1(a)(6)
%X is the grandparent of Y
grandparent(X,Y):- parent(X,Z),parent(Z,Y).

%1(a)(7)
%X is the ancestor of Y
ancestor(X,Y):- parent(X,Y).
ancestor(X,Y):- parent(X,Z),ancestor(Z,Y).

%1(a)(8)
%Who is the mother of Beatrice?
%Sarah is the mother of Beatrice
%| ?- mother(X,beatrice).
%X = sarah ? ;
%no

%1(a)(9)
%Who has four or more descendants?
%Elisabeth, George, Philip and Queenmother has four or more descendants
%| ?- bagof(Descend,ancestor(X,Descend),List),length(List,N),N>4.
%X = elisabeth,
%List = [charles,andrew,anne,edward,william,harry,georgejun,beatrice,eugenie,peter|...],
%N = 11 ? ;
%X = george,
%List = [elisabeth,charles,andrew,anne,edward,william,harry,georgejun,beatrice,eugenie|...],
%N = 12 ? ;
%X = philip,
%List = [charles,andrew,edward,william,harry,georgejun,beatrice,eugenie],
%N = 8 ? ;
%X = queenmother,
%List = [elisabeth,charles,andrew,anne,edward,william,harry,georgejun,beatrice,eugenie|...],
%N = 12 ? ;
%no

%1(a)(10)
%Who is a descendant of the Queenmother?
%Elisabeth, Charles, Andrew, Anne, Edward, William, Harry, Georgejun, Beatrice, Eugenie, Peter and Zara are the descendant of the Queenmother
%| ?- ancestor(queenmother,Y).
%Y = elisabeth ? ;
%Y = charles ? ;
%Y = andrew ? ;
%Y = anne ? ;
%Y = edward ? ;
%Y = william ? ;
%Y = harry ? ;
%Y = georgejun ? ;
%Y = beatrice ? ;
%Y = eugenie ? ;
%Y = peter ? ;
%Y = zara ? ;
%no



%1(b)
%X is the sibling of Y
sibling(X,Y):- parent(Z,X), parent(Z,Y), X\=Y.
%X is the aunt of Y
aunt(X,Y):- the_royal_females(A), member(X,A), sibling(X,Z), parent(Z,Y).

%Who are the siblings of Charles?
%Andrew, Anne, Edward are the siblings of Charles
%| ?- sibling(X,charles).
%X = andrew ? ;
%X = anne ? ;
%X = edward ? ;
%X = andrew ? ;
%X = edward ? ;
%no

%Who are the annts of William?
%Anne is the annt of William
%| ?- aunt(X,william).
%X = anne ? ;
%no



%1(c)
%Print out X stars
star(0).
star(X):- write('*'), NewX is X-1, star(NewX).

%Print out X spaces
space(0).
space(X):- write(' '), NewX is X-1, space(NewX).

%The upper part of the pattern
top(0,_).
top(X,Y):- star(X),NewY is (Y-X)*2,space(NewY),star(X),nl,NewX is X-1,top(NewX,Y).

%The lower part of the pattern
bottom(_,0,_).
bottom(X,Y,Z):- star(X),NewZ is (Z-X)*2,space(NewZ),star(X),nl,NewX is X+1,NewY is Y-1,bottom(NewX,NewY,Z).

%For the user to input the size
showPattern(0).
showPattern(N):- top(N,N),bottom(1,N,N).



%1(d)
%Calculate factorial of a number using accumulator(A)
factorial(0,X,X).
factorial(N,A,X):- N>0,NewN is N-1,NewA is N*A,factorial(NewN,NewA,X).

%For the user to input the number which is going to be calculated
factorial(N,X):- factorial(N,1,X).

%Add all numbers in a list
listsum([],0).
listsum([H|T],X):- listsum(T,NewX),X is NewX + H.

%The calculated numerator of the equation
topAns([H|T],X):- listsum([H|T],Y),factorial(Y,X).

%The calculated denuminator of the equation
bottomAns([],1).
bottomAns([H|T],X):- factorial(H,Y),bottomAns(T,NewX),X is NewX * Y.

%For the user to input the question and output the final answer
multinomial([H|T],X):- topAns([H|T],Y),bottomAns([H|T],Z), X is Y//Z.



%2
%Search the next posible move (not finished)
between(M,C,K):- M+C>0,M>=C,M>=0,C>=0,M+C=<K.
between(M,0,K):- M=<K,M>0.
between(0,C,K):- C=<K,C>0.
between(M,C,K):- M=<K,NewM is M+1,between(NewM,C,K).
between(M,C,K):- C=<K,NewC is C+1,between(M,NewC,K).

%Maintain legal boat status
legalBoat(M,0,K):- M=<K,M>0.
legalBoat(0,C,K):- C=<K,C>0.
legalBoat(M,C,K):- M+C>0,M>=C,M>=0,C>=0,M+C=<K.

%Maintain legal bank status
legalBank(M,C,_):- M>=C,M>=0,C>=0.
legalBank(0,C,_):- C>=0.
legalBank(M,C,W):- M>0,C>=0,W>0.

%Print out the weapon location for each step
weaponLoc(1):- write('W-L').
weaponLoc(0):- write('W-R').

%Print out the move of boat for each step
boatLoc(_,_,0):- write('Bank A <- Bank B').
boatLoc(_,_,1):- write('Bank A -> Bank B').
boatLoc(0,0,_):- write('Done!').

%Print out the solution
ans([]).
ans([[AM,AC,BM,BC,W,B]|T]):- weaponLoc(W),write(' {'),write(AM),write(' '),write(AC),write(' | '),write(BM),write(' '),write(BC),write('} : '), boatLoc(AM,AC,B),nl,ans(T).

%Keep new state not repeating steps
notMember(NewL,L):- \+member(NewL,L).

%try next move if boat on left (not finished)
%search(K,AM,AC,BM,BC,W,B,L):- B == 1,between(AM,AC,K),legalBank(AM,AC,W),legalBank(BM,BC,W),search(K,AM,AC,BM,BC,W,B,L).
%try next move if boat on right (not finished)
%search(K,AM,AC,BM,BC,W,B,L):- B == 0,between(BM,BC,K),legalBank(AM,AC,W),legalBank(BM,BC,W),search(K,AM,AC,BM,BC,W,B,L).

%base case
state(_,0,0,BM,BC,0,0,L):- ans(L).
state(K,AM,AC,BM,BC,W,B,L):- legalBank(AM,AC,W),legalBank(BM,BC,W),append(L,[[AM,AC,BM,BC,W,B]],Z),state(K,AM,AC,BM,BC,W,B,Z).

%Initialization
ferry(M,C,K):- state(K,M,C,0,0,1,1,[]).