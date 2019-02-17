# CS-205: Declarative Programming (Prolog)
#### November 2017
#### Coursework Assignment 2
#### Dr Xiuyi Fan, Dr Monika Seisenberger
Department of Computer Science<br/>
College of Science<br/>
Swansea University, Wales, UK<br/>
* The work has to be the group’s own work.
* Deadline for solutions: See COS intranet
* Your solution is to be submitted electronically as a single file.
* Name your submission file as LP_*GROUP_NUMBER*.pl (or LP_*GROUP_NUMBER*.txt), where *GROUP_NUMBER* is your group number.
* Use the CS-205 Assignments page on Blackboard for submission.
* Solution file format: .**pl** if accepted otherwise .**txt**.
* Embed results as comments in these files.
* Sufficient results should be given to test your code.
* Please register as a group on blackboard asap.
* Include group number, name(s) and student number(s) on the first page.
<br/>
<br/>

# Question 1: Recursion, Lists and Accumulating Parameters
1. Write the following program and compile it:
```
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
```
Define the following predicates on the persons in the program **ROYAL**.
   * **the_royal_females/1** (a list of all female members of the Royal Family)
   * **the_royal_males/1** (a list of all male members of the Royal Family)
   * **the_royal_family/1** (a list of all members of the Royal Family)
   * **mother/2**
   * **has_child/1.**
   * **grandparent/2**
   * **ancestor/2** (use recursion).
   
Translate the following questions into Prolog queries and try them out:
   * Who is the mother of Beatrice?
   * Who has four or more descendants?
   * Who is a descendant of the Queenmother?

[10 marks]

2. Use predicates of question (a) to define predicates **sibling/2** and **aunt/2** (w.r.t. the Royal Family). [Query: Who are the siblings of Charles? Who are the annts of William?]

[6 marks]

3. Write a predicate **showPattern(N)**, which takes an integer **N** and prints the following patterns, e.g., for **N=3** and **N=6**, respectively.
```
?- showPattern(3).
******
**  **
*    *
*    *
**  **
******
true ;
false.
?- showPattern(6).
************
*****  *****
****    ****
***      ***
**        **
*          *
*          *
**        **
***      ***
****    ****
*****  *****
************
true ;
false.
```
[8 marks]

4. Given n distinct objects, the notation, which is known as the *multinomial coefficient*,
```
```
represents the number of possible divisions of n objects into r distinct groups of respective sizes *n*1,*n*2,...,*n*r, (note that *n*1+*n*2+...+*n*r = *n*).
Write a predicate multinomial([*N*1,*N*2,...,*N*r],*M*) that compute the multinomial coefficients for groups of respective sizes *N*1,*N*2,...,*N*r.
E.g., the following outputs are expected:
```
?- multinomial([2,2,2,2],X).
X = 2520 ;
false.
?- multinomial([3,4,5,5],X).
X = 171531360 ;
false.
```
To get the full mark, your program needs to be efficiently implemented with tail recursion, e.g., the following query must return with the correct answer within 0.1s when running your program on our lab machine under SWIProlog. (Sicstus would not compute this query due to overflow.)
```
?- time(multinomial([2500,5200,5020,5020],X)).
% 106,465 inferences, 0.087 CPU in 0.087 seconds
% (100% CPU, 1222213 Lips)
```
[8 marks]

# Question 2: The Missionaries and Cannibals Problem
*M* missionaries and *C* cannibals must cross a river using a boat which can carry at most *K* people. There is a single weapon that can be shared among missionaries. (No cannibal can operate this weapon.) The constraints are the following:
1. on both banks, if there are missionaries presented, then
   * either they are not outnumbered by cannibals, or
   * one of the missionaries carries the weapon;
2. in the boat, if there are missionaries presented, then they must not be out numbered by cannibals (the weapon cannot be used on boat to protect missionaries);
3. the boat cannot cross the river by itself with no people on board operating it;
4. the weapon can be carried by cannibal if no missionary is presented.

The overall aim will be to write a Prolog program to solve the Missionaries and Cannibals problem; specifically, to define a predicate **ferry(M,C,K)** that prints the ferry steps, starting from the state where all missionaries and cannibals are on
bank **L** (initial state) to the state where all missionaries and cannibals are on bank **R** (goal state). Each step must be a legal ferry move.<br/>
You may consider the following hints.
1. Treat the problem as a state-transation model by defining a predicate
```
state(K,AM,AC,BM,BC,W,B,L)
```
with recursion. Here, arguments in **state(K,AM,AC,BM,BC,W,B,L)** denote the following. **K**: Boat capacity. **AM**: The number of missionaries on bank A. **AC**: The number of cannibals on bank A. **BM**: The number of missionaries on bank B. **BC**: The number of cannibals on bank B. **W**: The location of the weapon. **B**: The location of the boat. **L**: The state list, from the initial state to the goal state.

2. **ferry** sets the initial state with a rule:
```
ferry(M,C,K):-state(K,M,C,0,0,1,1,[]).
```
3. The base case of the recursion should be the final state,
```
state(_,0,0,BM,BC,-1,-1,L).
```
4. In each recursion step, a new state is explored and stored in **L**.
5. A new state is valid, e.g., to be further explored, if it meets all constraints and it does not exist in **L**.

[10 marks]<br/>
<br/>
Overall presentation:<br/>
[8 marks]<br/>
<br/>
[Total: 50 marks]
