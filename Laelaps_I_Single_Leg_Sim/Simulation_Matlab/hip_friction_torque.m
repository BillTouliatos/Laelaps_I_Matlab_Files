function tau = hip_friction_torque(th1dot)

slip_error = 0.01;
friction_velocity = 0.01;
tau_static = 0.6;
tau_slip = 0.99*tau_static;


if abs(th1dot) <= slip_error
    tau = sign(th1dot)*abs(th1dot)*(tau_static/slip_error); % stick
else
    tau = sign(th1dot)*tau_slip + sign(th1dot)* ...
        (tau_static-tau_slip)*exp(-abs(th1dot/friction_velocity)+1); % slip
end


    
end



