# hybrid-mpc
Model predictive control (MPC) implementation for vehicle cruise control.

Automatic gear-switching behavior is modelled as a hybrid mixed logical dynamical (MLD) system.
The MPC architecture was implemented by considering, among others, constraints on dynamics, velocity, and acceleration; as well as input saturation. The primary goal was to follow a changing reference velocity over a specific time span.

At each time step, an optimal throttle input is computed by using a mixed integer linear programming (MILP) optimizer. The input is then applied to the vehicle and the simulation is propagated to the next step.
