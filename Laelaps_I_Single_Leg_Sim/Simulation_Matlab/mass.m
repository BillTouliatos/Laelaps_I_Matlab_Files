function M = mass(t,x)

%-------------------------------------------------------------------------%
% All solvers solve systems of equations in the form 
% y' = f(t,y) or problems that involve a mass matrix, 
% M(t,y)y' = f(t,y). The ode23s solver can solve only 
% equations with constant mass matrices. ode15s and 
% ode23t can solve problems with a mass matrix that is 
% singular, i.e., differential-algebraic equations (DAEs).
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% All solvers solve systems of equations in the form 
% y' = f(t,y) or problems that involve a mass matrix, 
% M(t,y)y' = f(t,y). The ode23s solver can solve only 
% equations with constant mass matrices. ode15s and 
% ode23t can solve problems with a mass matrix that is 
% singular, i.e., differential-algebraic equations (DAEs).
%-------------------------------------------------------------------------%

global m1 m2 m3 I1 I2 I3 d1 d2 d3 g Lspring kspring bspring

%-------------------------------------------------------------------------%
% x(1) = th1 
% x(2) = th1dot 
% x(3) = th2
% x(4) = th2dot
% x(5) = l
% x(6) = ldot
%-------------------------------------------------------------------------%

th1 = x(1);
th1dot = x(2);
th2 = x(3);
th2dot = x(4);
l = x(5);
ldot = x(6);

%-------------------------------------------------------------------------%
% Mass matrix
%-------------------------------------------------------------------------%
M = zeros(6,6);

%-------------------------------------------------------------------------%
% from Mathematica we get
M(2,2)=I1+d1.^2.*(m1+4.*(m2+m3));
M(2,4)=2.*d1.*(l.*m3+d2.*(m2+m3)).*cos(th1+(-1).*th2);
M(2,6)=(-2).*d1.*m3.*sin(th1+(-1).*th2);
M(4,4)=I2+I3+l.*(2.*d2+l).*m3+d2.^2.*(m2+m3);
M(4,6)=0;
M(6,6)=m3;

%-------------------------------------------------------------------------%
% We add the symmetric elements
M(4,2)=M(2,4);
M(6,2)=M(2,6);
M(6,4)=M(4,6);

%-------------------------------------------------------------------------%
% We add aces for diagonal odd elements

M(1,1) = 1;
M(3,3) = 1;
M(5,5) = 1;



