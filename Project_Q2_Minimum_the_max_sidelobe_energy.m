% ���qch3 p34-35

clear all;
close all;
clc; 

NUM_ANA= 10;  %�ѽu�ƶq
CARR_FREQ= 2.3*(10^9); %���i
WAVE_LEN= (3*10^8)/CARR_FREQ; %�i��
ANTENNA_DIS= WAVE_LEN/2;
ANGLE_DES= 10;
ANGLE_INT= 40;
theta_l = 0;
theta_u = 15;

Steering_des=  [exp(-j*[0:NUM_ANA-1].'*2*pi*ANTENNA_DIS*sin(ANGLE_DES*pi/180)/WAVE_LEN)];
Steering_int=  [exp(-j*[0:NUM_ANA-1].'*2*pi*ANTENNA_DIS*sin(ANGLE_INT*pi/180)/WAVE_LEN)];

P_matrix= zeros(NUM_ANA, NUM_ANA);


% Worst-case design 

cvx_begin

variable w(10,1) complex  ;
variable t;
minimize t;

subject to
w' *Steering_des==1 

for i=-90:1:theta_l  %90�׶}�l�A�C�j�@�פ��Τ@���A��theta_l=0;����
    P_matrix= exp(-j*[0:NUM_ANA-1]'*2*pi*ANTENNA_DIS*sin(i*pi/180)/WAVE_LEN)*exp(-j*[0:NUM_ANA-1]'*2*pi*ANTENNA_DIS*sin(i*pi/180)/WAVE_LEN)';
    quad_form(w,P_matrix)<=t
end


for i= theta_u:1:90  %theta_u=15�}�l�A�C�j�@�פ��Τ@���A��90�׬���
    P_matrix=exp(-j*[0:NUM_ANA-1]'*2*pi*ANTENNA_DIS*sin(i*pi/180)/WAVE_LEN)*exp(-j*[0:NUM_ANA-1]'*2*pi*ANTENNA_DIS*sin(i*pi/180)/WAVE_LEN)';
    quad_form(w,P_matrix)<=t
end
  
  
cvx_end


steering_vec_plot=[];
for i=-90:1:90
    steering_vec_plot= [steering_vec_plot; exp(-j*[0:NUM_ANA-1]*2*pi*ANTENNA_DIS*sin(i*pi/180)/WAVE_LEN)];
end
plot([-90:1:90],10*log10(abs(w'*steering_vec_plot.').^2))
legend(['M=',num2str(NUM_ANA),',\theta_{d}=',num2str(ANGLE_DES),',\theta_{l}=',num2str(theta_l),',\theta_{u}=',num2str(theta_u)]);
title('Minimize the worst-case sidelobe energy');
xlabel('Angle(degree)');
ylabel('Angle response(dB)');