%%% This sub-script computes the optimization at each time step with
%%% integer linear programming.

[theta, fval, exitflag, output] = intlinprog(J, intcon, Phi, beta, Phi_eq, beta_eq, [], [], options);

