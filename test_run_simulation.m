% Setup script to initialize variables, run Simulink 
% simulation, and calculate performance metrics.

clear all

sim_label = "test_sim_01";

data_dir = "data";
% Subdirectory to store result files
results_dir = "results";
if ~exist(results_dir, 'dir')
    mkdir(results_dir)
end

% Input data
input_data_filename = "inputs_01.csv";

% Simulink model name
sim_model = "gain_sched_sim";

% Simulation input data
input_data = readtable(fullfile(data_dir, input_data_filename));

t = input_data.t;
assert(t(1) == 0)
Ts = diff(t(1:2));

% Input data struct used by simulation model
inputs = struct;
inputs.r = [t input_data.r];
inputs.p = [t input_data.p];
inputs.d = [t input_data.d];

% Controller parameters
params = struct;
params.Ti = 1000;
params.a = -0.1;
params.b = -4.9;
params.c = 5;

OP = run_simulation(sim_label, sim_model, input_data, params, ...
    results_dir);

assert(isequal(round(OP, 6), 0.002470))

