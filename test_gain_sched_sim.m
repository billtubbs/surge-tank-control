% Setup script to initialize variables, run Simulink 
% simulation, and calculate performance metrics.

clear all

rng(0)

% Select simulink model name
sim_model = "gain_sched_sim";

% Simulation time
nT = 3500;
Ts = 1;
t = Ts*(0:nT)';

% Tank level set-point
r = zeros(nT+1,1) + 60;
r(t >= 10) = 50;

% Measurement noise (on the output)
sigma_M = 0;
d = sigma_M * ones(nT+1,1);

% Input disturbance
wp = zeros(nT+1,1);
sigma_wp = 1;
wp((t >= 500) & (t < 1000)) = sigma_wp .* randn(500,1);
p = cumsum(wp);

% Input data
inputs = struct;
inputs.d = [t d];
inputs.p = [t p];
inputs.r = [t r];

% Controller parameters
params = struct;
params.Ti = 1000;
params.a = -0.1;
params.b = -4.9;
params.c = 5;

% Run simulation
out = sim(sim_model, "StopTime", string(t(end)));

% Evaluate controller performance

% Smoothness of tank discharge flow
% This is the mean-squared-difference in the control 
% moves over the whole simultion
MSD = mean(diff(out.u) .^ 2)

% Tank level limit exceedances
% This is the sum-of-squared exceedances of the upper and 
% lower safe operating limits (10% and 90% tank levels)
STLE = sum((max(out.y - 90, 0) + max(10 - out.y, 0)) .^ 2)

% Overall performance metric
OP = MSD + STLE

