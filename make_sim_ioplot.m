% Plot simulation results

addpath("~/ml-plot-utils")

figure(1); clf
U = [out.p out.u];
Y = out.y;
u_labels = ["$p(t)$" "$u(t)$"];
make_iorplot(Y,out.t,U,out.r,u_labels);