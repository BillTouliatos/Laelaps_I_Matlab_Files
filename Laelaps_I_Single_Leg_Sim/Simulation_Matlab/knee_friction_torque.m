function tau = knee_friction_torque(th2dot)

slip_error = 0.01;
friction_velocity = 0.01;
tau_static = 0.6;
tau_slip = 0.99*tau_static;


if abs(th2dot) <= slip_error
    tau = sign(th2dot)*abs(th2dot)*(tau_static/slip_error); % stick
else
    tau = sign(th2dot)*tau_slip + sign(th2dot)* ...
        (tau_static-tau_slip)*exp(-abs(th2dot/friction_velocity)+1); % slip
end


    
end



