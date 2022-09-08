close all;
clear all;

price = [14, 7, 6];
A = [0, 200, 110];
B1 = [0.19, 0.03, 0.1];
C = [63, 8, 29];
required = [2000, 1.2, 100];

cvx_begin

variable litchi
variable banana
variable pineapple

minimize(price*[litchi;banana;pineapple])

subject to

A*[litchi;banana;pineapple]>=2000
B1*[litchi;banana;pineapple]>=1.2
C*[litchi;banana;pineapple]>=100

litchi>=0
banana>=0
pineapple>=0

cvx_end