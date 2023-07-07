clear all
lambdaa= 0.077;
betaa= 0.006502;
delta= 0.0005;
rho= 0;
n0= 1;
yresult=zeros(1,2);
tresult=zeros(1,1);
%% 
F2= @(t,y)[((0-betaa)/delta)*y(1)+lambdaa*y(2); (betaa*y(1)/delta)-lambdaa*y(2)];
F1= @(t,y)[(((4*betaa*(2.71^(-2*t*t)))-betaa)/delta)*y(1)+lambdaa*y(2); (betaa*y(1)/delta)-lambdaa*y(2)];
%% 
t1span=[0:0.01:1];
t2span=[1:0.01:10];
y0=[1 betaa/(lambdaa*delta)];
%% 
tic
[t,y]=ode45(F1,t1span,y0);
y0=y(101,:);
yresult=[yresult;y];
tresult=[tresult;t];
[t,y]=ode113(F2,t2span,y0);
yresult=[yresult;y];
tresult=[tresult;t];
yresult(1,:)= [];
tresult(1,:)=[];
toc
%% 
elapsedTime = toc;
plot(tresult,yresult(:,1))