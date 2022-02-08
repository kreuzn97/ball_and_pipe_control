function action = set_pwm(device, pwm_value)
%% Sets the PWM of the fan
% Inputs:
%  ~ device: serialport object controlling the real world system
%  ~ pwm_value: A value from 0 to 4095 to set the pulse width modulation of
%  the actuator
% Outputs:
%  ~ action: the control action to change the PWM
%
% Created by:  Kyle Naddeo 2/4/2022
% Modified by: Cristine Le Ny 2/8/2022

%% Force PWM value to be valid
UB=4095;
LB=0;
pwm_value = max(min(pwm_value, UB), LB);

%% Send Command
action = ["P", num2str(pwm_value)];
write(device, action,"string")

end
