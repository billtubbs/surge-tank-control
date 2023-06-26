% Produce input-output plots for the following
% Simulink simulation model:
%  - surge_tank_level_sim.slx
%
% Run this script after running the simulation
%  

addpath("~/ml-plot-utils")

u_labels = ["$u(k)$" "$p(k)$"];

figure(1); clf
make_iorplot(y, t, [u p], r, u_labels)
sp1 = subplot(2,1,1);
ylim(sp1,axes_limits_with_margin(y, 0.1, [0 100]))

figure(2); clf
make_iorplot(y1, t, [u1 p], r, u_labels)
sp1 = subplot(2,1,1);
ylim(sp1,axes_limits_with_margin(y, 0.1, [0 100]))

figure(3); clf
make_iorplot(y2, t, [u2 p], r, u_labels)
sp1 = subplot(2,1,1);
ylim(sp1,axes_limits_with_margin(y, 0.1, [0 100]))

figure(4); clf
make_iorplot(y3, t, [u3 p], r, u_labels)
sp1 = subplot(2,1,1);
ylim(sp1,[0 100])
yline(15, '--', 'Parent', sp1)
yline(85, '--', 'Parent', sp1)
labels = sp1.Legend.String;
labels(3:4) = {'$y_{min}$', '$y_{max}$'};
set(sp1.Legend, 'String', labels)

figure(5); clf
make_iorplot(y4, t, [u4 p], r, u_labels)
sp1 = subplot(2,1,1);
ylim(sp1,[0 100])
yline(15, '--', 'Parent', sp1)
yline(85, '--', 'Parent', sp1)
labels = sp1.Legend.String;
labels(3:4) = {'$y_{min}$', '$y_{max}$'};
set(sp1.Legend, 'String', labels)

figure(6); clf
make_iorplot(y5, t, [u5 p], r, u_labels)
sp1 = subplot(2,1,1);
ylim(sp1,[0 100])
yline(15, '--', 'Parent', sp1)
yline(85, '--', 'Parent', sp1)
labels = sp1.Legend.String;
labels(3:4) = {'$y_{min}$', '$y_{max}$'};
set(sp1.Legend, 'String', labels)

figure(7); clf
make_iorplot(y6, t, [u6 p], r, u_labels)
sp1 = subplot(2,1,1);
ylim(sp1,[0 100])
yline(15,'--', 'Parent', sp1)
yline(85, '--', 'Parent', sp1)
labels = sp1.Legend.String;
labels(3:4) = {'$y_{min}$', '$y_{max}$'};
set(sp1.Legend, 'String', labels)

figure(7); clf
make_iorplot(y6, t, [u6 p], r, u_labels)
sp1 = subplot(2,1,1);
ylim(sp1,[0 100])
yline(15,'--', 'Parent', sp1)
yline(85, '--', 'Parent', sp1)
labels = sp1.Legend.String;
labels(3:4) = {'$y_{min}$', '$y_{max}$'};
set(sp1.Legend, 'String', labels)

figure(8); clf
make_iorplot(y7, t, [u7 p], r, u_labels)
sp1 = subplot(2,1,1);
ylim(sp1,[0 100])
yline(15,'--', 'Parent', sp1)
yline(85, '--', 'Parent', sp1)
labels = sp1.Legend.String;
labels(3:4) = {'$y_{min}$', '$y_{max}$'};
set(sp1.Legend, 'String', labels)

figure(9); clf
make_iorplot(y8, t, [u8 p], r, u_labels)
sp1 = subplot(2,1,1);
ylim(sp1,[0 100])
yline(15,'--', 'Parent', sp1)
yline(85, '--', 'Parent', sp1)
labels = sp1.Legend.String;
labels(3:4) = {'$y_{min}$', '$y_{max}$'};
set(sp1.Legend, 'String', labels)

figure(10); clf
make_iorplot(y9, t, [u9 p], r, u_labels)
sp1 = subplot(2,1,1);
ylim(sp1,[0 100])
yline(15,'--', 'Parent', sp1)
yline(85, '--', 'Parent', sp1)
labels = sp1.Legend.String;
labels(3:4) = {'$y_{min}$', '$y_{max}$'};
set(sp1.Legend, 'String', labels)