close all;
clear all;

price = [14, 7, 6];
A = [0, 200, 110];
B1 = [0.19, 0.03, 0.1];
C = [63, 8, 29];
required = [2000; 1.2; 100];
P=[2.5 0 0 ; 0 1.4 0 ; 0 0 1];
c=[A;B1;C]; %換個寫法

cvx_begin

variables x y z
variable t

minimize t

subject to

c*[x;y;z]>=required; %合併比較少行

x>=0;
y>=0;
z>=0;

price*[x;y;z]+norm(P*[x;y;z])<=t ; %加入P

cvx_end

litchi = x
banana = y
pineapple = z