% A MATLAB script to control Rowans Systems & Control Floating Ball 
% Apparatus designed by Mario Leone, Karl Dyer and Michelle Frolio. 
% The current control system is a PID controller.
%
% Created by Kyle Naddeo, Mon Jan 3 11:19:49 EST 
% Modified by Christine Le Ny 4/19/2022
%             Nicholas Kreuz

%% Start fresh
close all; clc; clear device;

%% Connect to device
device = serialport("COM5", 19200);

%% Parameters
target      = 0.6;   % Desired height of the ball [m]
sample_rate = 0.25;  % Amount of time between controll actions [s]

%% Environment
ObservationInfo= rlNumericSpec([2 1]);
ObservationInfo.Name= 'Ball State';
ObservationInfo.Description= 'x,dx';

ActionInfo = rlFiniteSetSpec([-1 0 1]);
ActionInfo.Name='Ball Action';

env = rlFunctionEnv(ObservationInfo,ActionInfo,'myStepFunction','myResetFunction');

[InitialObservation,LoggedSignals] = myResetFunction();

% Fix the random generator seed for reproducibility.
rng(0);
%% Give an initial burst to lift ball and keep in air
set_pwm(device, 4000); % Initial burst to pick up ball
pause(0.1) % Wait 0.1 seconds

%% Initialize variables

error       = 0;
error_sum   = 0;

%% Feedback loop
while true
    %% Read current height
    [distance,manual_pwm,target,deadpan] = read_data(device);
    % y = ir2y(add_proper_args); % Convert from IR reading to distance from bottom [m]
    
    %% Calculate errors for PID controller
    error_prev = error;             % D
    error      = target - y;        % P
    error_sum  = error + error_sum; % I
    
    %% Control
    prev_action = action;
    %action = % Come up with a scheme no answer is right but do something
    % set_pwm(add_proper_args); % Implement action
        
    % Wait for next sample
    pause(sample_rate)
end

%% Functions
function [InitialObservation,LoggedSignal]=myResetFunction()
%reset function to original ball place
x0=0;
dx0=0;

LoggedSignal.State=[x0,dx0];
InitialObservation= LoggedSignal.State;
end

function [NextObs,Reward,IsDone,LoggedSignals]=myStepFunction(Action,LoggedSignals)
%gravity
Gravity=9.8;
MaxPWM=2047.5;
Ts=.02;     %sampleTime
DisplacementThreshold=0.9144;

%reward for getting closer
RewardForStayingInSpot=5;
PenaltyForLeavingSystem=-10;

%check if function is valid
if ~ismember(Action,[-MaxPWM MaxPWM])
 error('Action must be %g for going left and %g for going right.',...
 -MaxPWM,MaxPWM);
end
PWM = Action;


%vector logged signals
State=LoggedSignals.State;
X0=State(2);
DX0=State(3);

%tranfer function 
s = tf('s');
pair=1.225;
veq=2.4384;
mball=.01;
Vball=6.510^(-5); 
c2=(2*Gravity*(mball-(pair*Vball)))/(veq*mball);
c3=6.378710^(-4);
G=(c3*c2)/(s*(s+c2));

%statespace
statespace=ss(G)
q=statespace.A;
a=[1500, 1500];
t=[0,.01];


LoggedSignals.State = lsim(statespace,statespace.A,t);

%transform state to observation 
NextObs = LoggedSignals.State;

% Check terminal condition.
X = NextObs(1);

%what is done(takes too long, says at spot)

IsDone = abs(X) > DisplacementThreshold;
IsDone1=(abs(x)==target&&(dx>-.001&&dx<.001));
IsDone2=t>30;

% Get reward.
if ~IsDone
 Reward = .001;
else
 Reward = PenaltyForLeavingSystem;
end

if ~IsDone2
    Reward=RewardForStayingInSpot;
end 
if IsDone2
    Reward = -5;
end 
end
