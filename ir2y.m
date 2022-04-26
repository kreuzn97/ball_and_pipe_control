function [y, pipe_percentage] = ir2y(ir)
%% Converts IR reading from the top to the distance in meters from the bottom
% Inputs:
%  ~ ir: the IR reading from time of flight sensor
% Outputs:
%  ~ y: the distance in [m] from the bottom to the ball
%  ~ pipe_percentage: on a scale of 0 (bottom of pipe) to 1 (top of pipe)
%  where is the ball
%
% Created by:  Kyle Naddeo 2/2/2022
% Modified by: Nicholas Kreuz 4/22/2022

%% Parameters
ir_bottom = 55;
ir_top    = 3;
y_top     = 0.9144; % Ball at top of the pipe [m]

%% Bound the IR reading and send error message 
ir_inv = ir_bottom - ir_top - ir;

%% Set
pipe_percentage = ir_inv / (ir_bottom - ir_top);
y = pipe_percentage * y_top;

