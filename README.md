# hybrid-mpc-for-adaptive-cruise-control
Model predictive control (MPC) implementation for cooperative adaptive cruise control.

Automatic gear-switching behavior is modeled as a hybrid mixed logical dynamical (MLD) system.
The MPC architecture was implemented by considering, among others, constraints on dynamics, velocity, acceleration, and input saturation. The primary goal was to follow a changing reference velocity over a specific period.

At each time step, an optimal throttle input is computed by using a mixed integer linear programming (MILP) optimizer. The input is then applied to the vehicle and the simulation is propagated to the next step.

### Results

Figure below shows the reference tracking behavior of the hybrid MPC. The reference velocity cannot be reached quickly enough in some parts of the graph due to constraints on vehicle acceleration.

![alt text](https://github.com/astroquest/hybrid-mpc-for-adaptive-cruise-control/blob/main/impl_mpc_54_vt.png?raw=true)
