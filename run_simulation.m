function OP = run_simulation(sim_label, sim_model, input_data, params, ...
    results_dir)
% Runs one simulation with the specified model, input data,
% and parameters, saves results to file, and returns the value 
% of the overall controller performance metric.

    addpath("~/ml-data-utils")

    t = input_data.t;
    assert(t(1) == 0)
    t_stop = t(end);
    Ts = diff(t(1:2));
    nT = length(t) - 1;

    % Input data struct used by simulation model
    inputs = struct;
    inputs.r = [t input_data.r];
    inputs.p = [t input_data.p];
    inputs.d = [t input_data.d];

    % Run Simulink simulation
    out = sim(sim_model, "StopTime", string(t_stop));

    % Simulation outputs:
    t = out.t;
    u = out.u;
    y = out.y;

    % Parameter values
    controller_params = objects2tablerow( ...
        containers.Map({'params'}, {params}) ...
    );

    % Evaluate controller performance
    % Smoothness of tank discharge flow
    % This is the mean-squared-difference in the control 
    % moves over the whole simultion
    MSD = mean(diff(u) .^ 2);

    % Tank level limit exceedances
    % This is the sum-of-squared exceedances of the upper and 
    % lower safe operating limits (10% and 90% tank levels)
    STLE = sum((max(y - 90, 0) + max(10 - y, 0)) .^ 2);

    % Overall performance metric (to be maximised)
    OP = MSD + STLE;

    metrics = table(MSD, STLE, OP);

    % Save summary results to file
    results_table = [ ...
        array2tablerow(datetime(), 'Time') ...
        table(sim_label, sim_model, t_stop, Ts, nT) ...
        controller_params ...
        metrics
    ];

    % Load existing results (if any)
    filename = "results_summary.csv";
    if isfile(fullfile(results_dir, sim_label, filename))
        % Load existing results and combine
        existing_results = readtable(fullfile(results_dir, sim_label, filename), ...
            'TextType','string');
        results_table = outerjoin(existing_results, results_table, ...
            'MergeKeys', true);
    end

    % Save all results to file
    if ~exist(fullfile(results_dir, sim_label), 'dir')
        mkdir(fullfile(results_dir, sim_label))
    end
    writetable(results_table, fullfile(results_dir, sim_label, filename));

end