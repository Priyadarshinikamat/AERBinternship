clear all
lambda=[0.0127 0.0317 0.115 0.311 1.4 3.87];
lambdaa= 0.077;
beta=[0.000266 0.001491 0.001316 0.002849 0.000896 0.000182];
betaa= 0.007;
delta= 0.00002;
rho= 0.003;
n0= 1;
%% 
F= @(t,y)[((rho-betaa)/delta)*y(1)+lambda(1)*y(2)+lambda(2)*y(3)+lambda(3)*y(4)+lambda(4)*y(5)+lambda(5)*y(6)+lambda(6)*y(7); (beta(1)*y(1)/delta)-lambda(1)*y(2); (beta(2)*y(1)/delta)-lambda(2)*y(3); (beta(3)*y(1)/delta)-lambda(3)*y(4); (beta(4)*y(1)/delta)-lambda(4)*y(5); (beta(5)*y(1)/delta)-lambda(5)*y(6); (beta(6)*y(1)/delta)-lambda(6)*y(7)];
%% 
tspan=[0:0.001:20];
y0=[1 beta(1)/(lambda(1)*delta) beta(2)/(lambda(2)*delta) beta(3)/(lambda(3)*delta) beta(4)/(lambda(4)*delta) beta(1,5)/(lambda(1,5)*delta) beta(1,6)/(lambda(1,6)*delta)];
%% 
tic
[t,y]=ode23t(F,tspan,y0);
toc
%% 
elapsedTime = toc;
plot(t,y(:,1))