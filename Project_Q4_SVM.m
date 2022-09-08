close all
clear all
clc

height_1=[195,198,173,198,189,173,178,186,199,199];
height_2=[153,170,170,160,166,152,158,169,166,170];
weight_1=[80,61,86,88,81,83,83,72,80,65];
weight_2=[54,40,45,40,42,57,54,46,59,40];

x=[[height_1,height_2];[weight_1,weight_2]];
y = [1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
N = 20;

cvx_begin

variable w(2,1)
variable b

minimize(norm(w)/2)

subject to

for i=1:N
    y(:,i)*(w'*x(:,i)+b)>=1;
end    

cvx_end
figure (1)
plot(height_1,weight_1,'b*')
hold on
plot(height_2,weight_2,'ro')

figure (2)
plot(height_1,weight_1,'b*')
hold on
plot(height_2,weight_2,'ro')
plot([150:1:200],(-b-w(1)*[150:1:200])/w(2),'k')
hold on
plot([150:1:200],(1-b-w(1)*[150:1:200])/w(2),'k--')
hold on
plot([150:1:200],(-1-b-w(1)*[150:1:200])/w(2),'k--')

