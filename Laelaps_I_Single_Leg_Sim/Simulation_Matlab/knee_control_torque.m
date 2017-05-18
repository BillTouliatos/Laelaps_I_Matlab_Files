function tau = knee_control_torque(th2, th2dot)

kp = 100;
kd = 10;

th2des = -deg2rad(40);

tau = kp*(th2des - th2) - kd*(th2dot);

end