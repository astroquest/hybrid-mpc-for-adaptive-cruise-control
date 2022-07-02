close all
set(0,'DefaultFigureWindowStyle','docked')
% set(0,'DefaultFigureWindowStyle','normal')
% set(gca,'FontSize',14)
% set(findall(gcf,'-property','FontSize'),'FontSize',14)

t = 0:T:sim_time-T;

figure  % v and v_ref
hold on
plot(t, v(1:end-1), "linewidth", 1.5)
plot(t, v_ref, "--", "linewidth", 1.5)
hold off
title("Actual and reference velocity as a function of time")
xlabel("time (s)")
ylabel("velocity (m/s)")
legend("velocity", "reference",  "location", "northwest")
set(gca,'FontSize',14)
grid

figure  % v - v_ref
plot(t, abs(v(1:end-1)-v_ref), "linewidth", 1.5)
title("Absolute value of actual minus reference velocity as a function of time")
xlabel("time (s)")
ylabel("||velocity - reference velocity|| (m/s)")
set(gca,'FontSize',14)
grid

figure  % position
plot(t, x, "linewidth", 1.5)
title("Position as a function of time")
xlabel("time (s)")
ylabel("position (m)")
set(gca,'FontSize',14)
grid

figure  % position - velocity plane
plot(x, v(1:end-1), "linewidth", 1.5)
hold on
plot(x, v_ref, "--", "linewidth", 1.5)
hold off
title("Position versus velocity plane")
xlabel("position (m)")
ylabel("velocity (m/s)")
legend("velocity", "reference", "location", "northwest")
set(gca,'FontSize',14)
grid

figure  % acceleration
plot(t, a, "linewidth", 1.5)
title("Acceleration as a function of time")
xlabel("time (s)")
ylabel("acceleration (m/s^2)")
yline(a_comf_max)
yline(-a_comf_max)
legend("acceleration", "comfort limits", "location", "southeast")
set(gca,'FontSize',14)
grid

figure  % throttle input
plot(t, u, "linewidth", 1.5)
title("Throttle input as function of time")
xlabel("time (s)")
ylabel("throttle input (-)")
yline(u_max)
yline(u_min)
legend("throttle input", "limits",  "location", "southeast")
set(gca,'FontSize',14)
grid

figure  % Delta throttle input
plot(t, Du, "linewidth", 1.5)
title("Throttle input change as function of time")
xlabel("time (s)")
ylabel("\Delta u (-)")
set(gca,'FontSize',14)
grid

figure  % optimization time
plot(t, optim_time, "linewidth", 1.5)
title("Optimization time per discrete step as a function of simulation time")
xlabel("time (s)")
ylabel("optimization time (s)")
yline(T)
legend("optimization time", "sampling time")
set(gca,'FontSize',14)
grid

figure  % optimization time
plot(t, cost, "linewidth", 1.5)
title("Cost function as a function of simulation time")
xlabel("time (s)")
ylabel("Cost")
set(gca,'FontSize',14)
grid

% figure  % integers delta
% plot(t, delta, "linewidth", 1.5)
% title("Integer values of \delta as function of time")
% xlabel("time (s)")
% ylabel("\delta (-)")
% legend("\delta_1", "\delta_2", "\delta_3")
% set(gca,'FontSize',14)
% grid
% 
% figure  % aux. variables z
% plot(t, z, "linewidth", 1.5)
% title("Auxiliary variable values as function of time")
% xlabel("time (s)")
% ylabel("z")
% legend("z_1 (-)", "z_2 (m/s)", "z_3 (-)")
% set(gca,'FontSize',14)
% grid