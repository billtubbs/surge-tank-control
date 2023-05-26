% Generates multiple sets of random input data
% for simulations.
%

clear all

% Subdirectory to store input data files
data_dir = "data";
if ~exist(data_dir, 'dir')
    mkdir(data_dir)
end

% Specify seeds for random number generator
seeds = 0:10;

% Simulation time
nT = 5000;
Ts = 1;
t = Ts*(0:nT)';

figure(10); clf
hold on

n_seeds = length(seeds);
for i = 1:n_seeds

    seed = seeds(i);
    rng(seed)

    % Tank level set-point
    r = zeros(nT+1,1) + 60;
    r(t >= 10) = 50;

    % Measurement noise and output disturbances
    sigma_M = 0;
    d = sigma_M * ones(nT+1,1);

    % BRW Example from paper
    beta = -15;  % notation change beta = k from Nicolau paper
    alpha1 = 1;
    alpha2 = 1;
    tau = 0;
    phi = 0.5;

    % Std. dev. of disturbance noise signal
    sd_e = 0.5;

    % Initial state
    xkm1 = 0;

    p = zeros(nT+1, 1);
    N = nT-1500;
    p(t >= 500 & t < 4000) = ...
        sample_bounded_random_walk(sd_e, beta, alpha1, alpha2, N, ...
        tau, phi, xkm1);

    plot(t, p, 'Linewidth', 2, 'Color', [0  0.4470  0.7410 0.25]);

    filename = sprintf("inputs_%02d.csv", i);
    data = table(t, r, d, p);
    writetable(data, fullfile(data_dir, filename))

end
set(gca,'TickLabelInterpreter','latex')
ylim([-16 16])
xlabel('Time $(t)$','Interpreter','latex')
ylabel('$p(k)$','Interpreter','latex')
grid on
