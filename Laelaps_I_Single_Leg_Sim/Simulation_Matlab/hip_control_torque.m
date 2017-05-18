function tau = hip_control_torque(th1, th1dot)

kp = 100;
kd = 10;

th1des = deg2rad(40);

tau = kp*(th1des - th1) - kd*(th1dot);

end

