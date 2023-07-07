lambda = [0.0127 0.0317 0.115 0.311 1.4 3.87]; 
%lambdaa = 0.077;
beta = [0.000285 0.0015975 0.001410 0.0030525 0.00096 0.000195];
betaa = 0.0075;
delta = 0.0005;
rho = 0.5*betaa;
n0 = 1;
ramp_reactivity = 1*betaa;
ramp_reactivity2 = -1*betaa;
yresult=zeros(1,7);
tresult=zeros(1,1);

%ramp_reactivity = 1*betaa*1000; % Ramp reactivity rate: 0.01$/sec
%ramp_reactivity2 = -1*betaa*1000; % Ramp reactivity rate: 0.01$/sec
%% 

F1 = @(t, y) [
    ((ramp_reactivity * t-betaa) / delta) * y(1) + lambda(1) * y(2) + lambda(2) * y(3) + lambda(3) * y(4) + lambda(4) * y(5) + lambda(5) * y(6) + lambda(6) * y(7);
    (beta(1) * y(1) / delta) - lambda(1) * y(2);
    (beta(2) * y(1) / delta) - lambda(2) * y(3);
    (beta(3) * y(1) / delta) - lambda(3) * y(4);
    (beta(4) * y(1) / delta) - lambda(4) * y(5);
    (beta(5) * y(1) / delta) - lambda(5) * y(6);
    (beta(6) * y(1) / delta) - lambda(6) * y(7)
];
F2 = @(t, y) [
    ((0.5*ramp_reactivity+ramp_reactivity2 * t-betaa) / delta) * y(1) + lambda(1) * y(2) + lambda(2) * y(3) + lambda(3) * y(4) + lambda(4) * y(5) + lambda(5) * y(6) + lambda(6) * y(7);
    (beta(1) * y(1) / delta) - lambda(1) * y(2);
    (beta(2) * y(1) / delta) - lambda(2) * y(3);
    (beta(3) * y(1) / delta) - lambda(3) * y(4);
    (beta(4) * y(1) / delta) - lambda(4) * y(5);
    (beta(5) * y(1) / delta) - lambda(5) * y(6);
    (beta(6) * y(1) / delta) - lambda(6) * y(7)
];
F3 = @(t, y) [
    ((rho -betaa) / delta) * y(1) + lambda(1) * y(2) + lambda(2) * y(3) + lambda(3) * y(4) + lambda(4) * y(5) + lambda(5) * y(6) + lambda(6) * y(7);
    (beta(1) * y(1) / delta) - lambda(1) * y(2);
    (beta(2) * y(1) / delta) - lambda(2) * y(3);
    (beta(3) * y(1) / delta) - lambda(3) * y(4);
    (beta(4) * y(1) / delta) - lambda(4) * y(5);
    (beta(5) * y(1) / delta) - lambda(5) * y(6);
    (beta(6) * y(1) / delta) - lambda(6) * y(7)
];
%% 

t1span = [0:0.0001:0.5];
t2span = [0.5:0.0001:1];
t3span = [1:0.0001:1.5];
t4span = [1.5:0.0001:12];
y0 = [1 beta(1) / (lambda(1) * delta) beta(2) / (lambda(2) * delta) beta(3) / (lambda(3) * delta) beta(4) / (lambda(4) * delta) beta(5) / (lambda(5) * delta) beta(6) / (lambda(6) * delta)];
%% 

tic
[t, y] = ode23s(F1, t1span, y0);
y0=y(5001,:);
yresult=[yresult;y];
tresult=[tresult;t];
[t, y] = ode23s(F2, t2span, y0);
y0=y(5001,:);
yresult=[yresult;y];
tresult=[tresult;t];
[t, y] = ode23s(F1, t3span, y0);
y0=y(5001,:);
yresult=[yresult;y];
tresult=[tresult;t];
[t, y] = ode23s(F3, t4span, y0);
yresult=[yresult;y];
tresult=[tresult;t];
toc
%% 
yresult(1,:)=[];
tresult(1,:)=[];

elapsedTime = toc;
plot(tresult, yresult(:, 1));
