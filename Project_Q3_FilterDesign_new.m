% number of FIR coefficients (including the zeroth one)
n = 20;

% rule-of-thumb frequency discretization
m = 15*n;
w = linspace(0,pi,m)'; % omega

%********************************************************************
% construct the desired filter
%********************************************************************
% fractional delay
D = 10;            % delay value

% Gaussian filter with linear phase
var = 0.05;
Hdes = exp(-j*D*w).*(1/(sqrt(2*pi*var))*exp(-(w-pi/2).^2/(2*var)));

%*********************************************************************
% solve the minimax (Chebychev) design problem
%*********************************************************************
% A is the matrix used to compute the frequency response
% A(w,:) = [1 exp(-j*w) exp(-j*2*w) ... exp(-j*n*w)]
A = exp( -j*kron(w,[0:n-1]) );

% optimal filter design
cvx_begin

variable h(n,1)
minimize(max(abs(A*h-Hdes)))


cvx_end


%*********************************************************************
% plotting routines
%*********************************************************************
% plot the FIR impulse reponse
figure(1)
stem([0:n-1],h)
xlabel('n')
ylabel('h(n)')

% plot the frequency response
H = [exp(-j*kron(w,[0:n-1]))]*h;
figure(2)
% magnitude
subplot(2,1,1);
plot(w,20*log10(abs(H)),w,20*log10(abs(Hdes)),'--')
xlabel('w')
ylabel('mag H in dB')
axis([0 pi -30 10])
legend('optimized','desired','Location','SouthEast')
% phase
subplot(2,1,2)
plot(w,angle(H),w,angle(exp(-j*D*w)),'--')
axis([0,pi,-pi,pi])
xlabel('w'), ylabel('phase H(w)')