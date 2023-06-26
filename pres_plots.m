%% Plots for presentation on process autonomy


rng(0)

t = (0:100)';

e1 = randn(101, 1);
e2 = randn(101, 1);
e3 = randn(101, 1);

p = 50 + cumsum(0.5 * e1) + e3;
p((t > 36) & (t < 56)) = 0;
u = p;
y = 50 + e2;

y2 = 50 + 0.05*cumsum(u - y);

figure(1); clf; 
plot(t, u, 'Linewidth', 2); 
ylim([0 100]); 
xlabel('Time')
ylabel('Flowrate')
p = get(gcf, 'Position');
set(gcf, 'Position', [p(1:2) 280 220]);

figure(2); clf; 
plot(t, y, 'Linewidth', 2); 
ylim([0 100]); 
xlabel('Time')
ylabel('Flowrate')
p = get(gcf, 'Position');
set(gcf, 'Position', [p(1:2) 280 220]);

figure(3); clf; 
plot(t, y2, 'Linewidth', 2); 
ylim([0 100]); 
xlabel('Time')
ylabel('Level')
p = get(gcf, 'Position');
set(gcf, 'Position', [p(1:2) 280 220]);