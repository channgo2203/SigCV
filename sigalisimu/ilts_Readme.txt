How to use the Bisimu lib in SIGALI

1. Load the *z3z data file and libs
> load("Bibli.lib");
> load("Implicit.lib");
> load("iLTS.lib");
> load("*.3z3");

2. Create an implicit PDS: S_I1, S_I2
> sys: system(events,states,evolutions,initialisations,constraints,controllables);
> ilts: implicit_sys(sys);s

3. Compute the bi-simulation between S_I1 and S_I2
> load("ilts_bisimulation_eventsame.lib"); %if the events sets of S_I1 and S_I2 are the same. Otherwise load
> load("ilts_bisimulation.lib");
> bisimu: ilts_bisimulation(S_I1,S_I2);
> bisimu;

4. Compute the simulation between S_I1 and S_I2
> load("ilts_simulation_eventsame.lib"); %if the events sets of S_I1 and S_I2 are the same. Otherwise load
> load("ilts_simulation.lib");
> simu: ilts_simulation(S_I1,S_I2);
> simu;
