
hold all
i=1;
tau = [];

for v=-2:0.001:2
    tau1 = hip_friction_torque(v);
    tau(i) = tau1;
    vel(i) = v;
    i=i+1;
end

plot(vel,tau,'-')