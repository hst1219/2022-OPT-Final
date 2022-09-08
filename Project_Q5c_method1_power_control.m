clear all;
clc;
close all;

G = [1 0.02 0.1 ; 0.05 1 0.06 ; 0.002 0.003 1];
variance = 0.01;
P_max = 10;

cvx_begin gp

variable t
variable p(3)
minimize(t)    
subject to

 for i=1:3
     P_max^(-1)*p(i) <= 1
    sum = 0;
for j=1:3
    if i~=j
     sum=sum+((t^(-1))*G(i,j)*(G(i,i)^(-1))*p(j)*(p(i)^(-1)))
    end
end
sum+(0.01*(t^(-1))*(G(i,i)^(-1))*(p(i)^(-1))) <= 1
 end
    
cvx_end

ub = 30;
lb= -30;
x = p(1);
y = p(2);
z = p(3);
for i = 1:20
    t=(ub+lb)/2;

    if(0.02*(y/x)+0.1*(z/x)+(0.01/x)<=t)||(0.05*x/y+0.06*z/y+(0.01/y)<=t)||(0.002*(x/z)+0.003*y/z+(0.01/z)<=t)
        ub = t;
    else
        lb = t;
    end
end


fprintf ('p(1) = %f \n ', p(1)); 
fprintf ('p(2) = %f \n ', p(2));
fprintf ('p(3) = %f\n ', p(3));

%fprintf ('最佳值 = %f \n ', log(exp(b)));
%fprintf ('本題所求min t = %f \n ', answer);
%p(1)=exp(y(1));
%p(2)=exp(y(2));
%p(3)=exp(y(3));