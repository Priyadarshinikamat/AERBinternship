clear all
lambda = [0.0124 0.0305 0.111 0.301 1.14 3.01];
lambdaa = 0.077;
beta = [0.000215 0.001424 0.001274 0.002568 0.000748 0.000273];
 
betaa = 0.006;
delta = 0.0005;
rho = betaa;
n0 = 1;
%% 
% F= @(t,y)[((((betaa/10)*y(1))-betaa)/delta)*y(1)+lambda(1)*y(2)+lambda(2)*y(3)+lambda(3)*y(4)+lambda(4)*y(5)+lambda(5)*y(6)+lambda(6)*y(7); (beta(1)*y(1)/delta)-lambda(1)*y(2); (beta(2)*y(1)/delta)-lambda(2)*y(3); (beta(3)*y(1)/delta)-lambda(3)*y(4); (beta(4)*y(1)/delta)-lambda(4)*y(5); (beta(5)*y(1)/delta)-lambda(5)*y(6); (beta(6)*y(1)/delta)-lambda(6)*y(7)];
F = @(t, y) [
    (((betaa/(10*y(1)))-betaa) / delta) * y(1) + lambda(1) * y(2) + lambda(2) * y(3) + lambda(3) * y(4) + lambda(4) * y(5) + lambda(5) * y(6) + lambda(6) * y(7);
    (beta(1) * y(1) / delta) - lambda(1) * y(2);
    (beta(2) * y(1) / delta) - lambda(2) * y(3);
    (beta(3) * y(1) / delta) - lambda(3) * y(4);
    (beta(4) * y(1) / delta) - lambda(4) * y(5);
    (beta(5) * y(1) / delta) - lambda(5) * y(6);
    (beta(6) * y(1) / delta) - lambda(6) * y(7)
];

%% 
tspan=[0:0.0001:10];
y0=[1 beta(1)/(lambda(1)*delta) beta(2)/(lambda(2)*delta) beta(3)/(lambda(3)*delta) beta(4)/(lambda(4)*delta) beta(1,5)/(lambda(1,5)*delta) beta(1,6)/(lambda(1,6)*delta)];
%% 
tic
[t,y]=ode23(F,tspan,y0);
toc
%% 
elapsedTime = toc;
plot(t,y(:,1))
