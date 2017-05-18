function Fmatrix = dynamics(t,x)

global m1 m2 m3 I1 I2 I3 d1 d2 d3 g Lspring kspring bspring
global xoutE toutE tau1E tau2E FyE FxE

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
% Torques
%-------------------------------------------------------------------------%
% tau1 = hip_control_torque(th1, th1dot) - hip_friction_torque(th1dot);
% tau2 = knee_control_torque(th2, th2dot)- knee_friction_torque(th2dot);
% tau1 = -hip_friction_torque(th1dot);
% tau2 = -knee_friction_torque(th2dot);
tau1 = hip_control_torque(th1, th1dot);
tau2 = knee_control_torque(th2, th2dot);


%-------------------------------------------------------------------------%
% Forces at the foot
%-------------------------------------------------------------------------%
if t>4
    Fx = 0;
    Fy = 7.3;
else 
    Fx = 0;
    Fy = 0;
end
    
%-------------------------------------------------------------------------%
% F matrix
%-------------------------------------------------------------------------%
Fmatrix = zeros(6,1);


%-------------------------------------------------------------------------%
% from Mathematica we get
%-------------------------------------------------------------------------%
Fmatrix(2)=tau1+2.*d1.*Fx.*cos(th1)+(-4).*d1.*ldot.*m3.*th2dot.*cos( ...
  th1+(-1).*th2)+d1.*(2.*Fy+(-1).*g.*(m1+2.*(m2+m3))).*sin( ...
  th1)+(-2).*d1.*(l.*m3+d2.*(m2+m3)).*th2dot.^2.*sin(th1+(-1) ...
  .*th2);
Fmatrix(4)=tau2+(-2).*d2.*ldot.*m3.*th2dot+(d2+d3).*Fx.*cos(th2)+2.* ...
  d1.*d2.*(m2+m3).*th1dot.^2.*sin(th1+(-1).*th2)+(d3.*Fy+d2.*( ...
  Fy+(-1).*g.*(m2+m3))).*sin(th2)+l.*((-2).*ldot.*m3.*th2dot+ ...
  Fx.*cos(th2)+2.*d1.*m3.*th1dot.^2.*sin(th1+(-1).*th2)+(Fy+( ...
  -1).*g.*m3).*sin(th2));
Fmatrix(6)=(-1).*kspring.*l+(-1).*bspring.*ldot+kspring.*Lspring+(d2+l) ...
  .*m3.*th2dot.^2+2.*d1.*m3.*th1dot.^2.*cos(th1+(-1).*th2)+( ...
  -1).*Fy.*cos(th2)+g.*m3.*cos(th2)+Fx.*sin(th2);


%-------------------------------------------------------------------------%
% We add the odd elements
%-------------------------------------------------------------------------%
Fmatrix(1) = th1dot;
Fmatrix(3) = th2dot;
Fmatrix(5) = ldot;


%-------------------------------------------------------------------------%
% Gathering and Saving All the Data - EXTENDED VECTORS 
% (these vectors include the whole history of data including the backs and 
% forths of the solvers in order to satisfy the desired accuracy
% i.e. these vectors are expected to have far more elements than output
% vectors and can be used for checking)
%-------------------------------------------------------------------------%
% Coords, velocities and time - E stands for EXTENDED
xoutE = [xoutE; x'];
toutE = [toutE; t];
% Torques at joints
tau1E = [tau1E; tau1];
tau2E = [tau2E; tau2];
% Force at the foot
FyE = [FyE; Fy];
FxE = [FxE; Fx];



%-------------------------------------------------------------------------%
% Printing time
%-------------------------------------------------------------------------%
disp(t) 
