clear all;
clc;
close all;

G = [1 0.02 0.1 ; 0.05 1 0.06 ; 0.002 0.003 1];
variance = 0.01;
P_max1 = 10;
P_max2 = 10;
P_max3 = 10;
gamma=10;


cvx_begin 
 
variable t
variable P(3)
minimize(sum(P))

subject to
P_max1^(-1)*P(1)<=1
P_max2^(-1)*P(2)<=1
P_max3^(-1)*P(3)<=1

gamma*G(1,2)*P(2)+gamma*G(1,3)*P(3)-G(1,1)*P(1)+gamma*variance<=0

gamma*G(2,1)*P(1)+gamma*G(2,3)*P(3)-G(2,2)*P(2)+gamma*variance<=0

gamma*G(3,1)*P(1)+gamma*G(3,2)*P(2)-G(3,3)*P(3)+gamma*variance<=0

P(1)>=0
P(2)>=0
P(3)>=0    


cvx_end


%fprintf ('最佳值 = %f \n ', log(exp(b)));
%fprintf ('本題所求min t = %f \n ', answer);
%p(1)=exp(y(1));
%p(2)=exp(y(2));
%p(3)=exp(y(3));


fprintf ('p(1) = %f \n ', P(1)); 
fprintf ('p(2) = %f \n ', P(2));
fprintf ('p(3) = %f\n ', P(3));