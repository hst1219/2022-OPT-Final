clear all;
clc;
close all;

G = [1 0.02 0.1 ; 0.05 1 0.06 ; 0.002 0.003 1];
variance = 0.01;
P_max1 = 10;
P_max2 = 10;
P_max3 = 10;

cvx_begin gp

variable t
variable p(3)
minimize(t)

subject to

P_max1^(-1)*p(1)<=1
P_max2^(-1)*p(2)<=1
P_max3^(-1)*p(3)<=1

t^(-1)*G(1,2)*(G(1,1)^(-1))*p(2)*(p(1)^(-1))+t^(-1)*G(1,3)*(G(1,1)^(-1))*p(3)*(p(1,1)^(-1))+variance*(t^(-1))*(G(1,1)^(-1))*(p(1)^(-1))<=1
t^(-1)*G(2,1)*(G(2,2)^(-1))*p(1)*(p(2)^(-1))+t^(-1)*G(2,3)*(G(2,2)^(-1))*p(3)*(p(2,1)^(-1))+variance*(t^(-1))*(G(2,2)^(-1))*(p(2)^(-1))<=1
t^(-1)*G(3,1)*(G(3,3)^(-1))*p(1)*(p(3)^(-1))+t^(-1)*G(3,2)*(G(3,3)^(-1))*p(2)*(p(3,1)^(-1))+variance*(t^(-1))*(G(3,3)^(-1))*(p(3)^(-1))<=1

cvx_end



%fprintf ('最佳值 = %f \n ', log(exp(b)));
%fprintf ('本題所求min t = %f \n ', answer);
%p(1)=exp(y(1));
%p(2)=exp(y(2));
%p(3)=exp(y(3));


fprintf ('p(1) = %f \n ', p(1)); 
fprintf ('p(2) = %f \n ', p(2));
fprintf ('p(3) = %f\n ', p(3));