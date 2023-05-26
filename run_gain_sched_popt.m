% This script runs a series of simulations and uses
% Bayesian optimization to find the best set of
% controller parameters.

clear all
rng default

% Select simulink model name
sim_model = "gain_sched_sim";

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

sim_label = "test_sim_01";

%p1 = optimizableVariable('log10_Ti',[1,4],'Type','real');
p1 = optimizableVariable('log10_am',[-2,1],'Type','real');
p2 = optimizableVariable('log10_bm',[0,2],'Type','real');
p3 = optimizableVariable('log10_c',[0,2],'Type','real');

fun = @(x) run_sim(x, sim_label, sim_model, input_data, results_dir);

% Test evaluation of function
x0 = array2table( ...
    [log10(0.1) log10(4.9) log10(5)], ...
    'VariableNames', {'log10_am', 'log10_bm', 'log10_c'} ...
);
objective = fun(x0);
assert(isequal(round(objective, 4), 0.2692))

results = bayesopt(fun, [p1,p2,p3], 'Verbose', 1, ...
    'AcquisitionFunctionName','expected-improvement-plus');


function objective = run_sim(x, sim_label, sim_model, input_data, results_dir)

    params.Ti = 1000;
    params.a = -(10 .^ x{1, 'log10_am'});
    params.b = -(10 .^ x{1, 'log10_bm'});
    params.c = 10 .^ x{1, 'log10_c'};

    % MATLAB bayesopt will minimize the function
    objective = 100 .* run_simulation(sim_label, sim_model, input_data, ...
        params, results_dir);

end

