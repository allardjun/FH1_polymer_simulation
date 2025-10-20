# FH1_polymer_simulation

Contains code to simulate FH1 domain polymer dynamics on the fast-timescale; Used for Bogue et al., *Formin N-terminal dimerization can impact F-actin assembly via polymer mechanics of the FH1 domain*, publication pending.

## Contents

* ``src/PolymerCode/``: c scripts and parameters text file used to run coarse-grain simulations.
* ``drivers/``: Bash scripts used to initiate simulation runs.
* ``analysis/``: MATLAB scripts to analyze simulation results.
* ``runs/``: simulation output files and visualizations; includes example files.

## Quick Start

#### Set-up

1. Clone this repository to your machine
2. Install MATLAB (The MathWorks, Inc.) if not already installed

#### Example 1: Simulating a short non-N-terminally dimerized FH1 domain

1. Navigate to the ``drivers/`` directory

   ```
   cd drivers
   ```
2. Run a simulation of a short (50 amino acids long) non-N-terminally dimerized FH1 domain

   ```
   bash runPolymerCodeQuick.sh
   ```

   This will save 2 files to the ``runs/`` directory: live_outputNonDimer.txt and outputNonDimer.txt. The former contains simulation outputs at intermediate timesteps, and the latter contains the simulation result for the final iteration.

   Expected runtime ~5-15 minutes.
3. Navigate to the ``analysis/`` directory

   ```
   cd analysis
   ```
4. Generate a simple visualization of the results

   Either open the MATLAB GUI and run ``visualizePolymerCodeQuick.m`` or run via command-line

   This will generate plots of 1) local effective concentration of each binding site at the origin (with theory overplotted) and 2) occlusion probability of each bindng site. The plots will be saved as polymerCodeVisualQuick.png in the ``runs/`` directory.

#### Example 2: Simulating a short non-N-terminally dimerized and N-terminally dimerized FH1 domain

1. Navigate to the ``drivers/`` directory

   ```
   cd drivers
   ```
2. Run a simulation of a short (50 amino acids long) non-N-terminally dimerized and an N-terminally dimerized FH1 domain

   ```
   bash runPolymerCode.sh
   ```
   This will save 4 files to the ``runs/`` directory: live_outputNonDimer.txt, live_outputDimer.txt, outputDimer.txt, and outputNonDimer.txt. The first two files contain simulation outputs at intermediate timesteps, and the latter two files contain the simulation results for the final iterations.

   Expected runtime ~13 hours.
3. Navigate to the ``analysis/`` directory

   ```
   cd analysis
   ```
4. Generate a simple visualization of the results

   Either open the MATLAB GUI and run ``visualizePolymerCode.m`` or run via command-line

   This will generate plots of 1) the ratio (dimerized/undimerized) of local effective concentration of each binding site at the origin and 2) the ratio (dimerized/undimerized) occlusion probability of each bindng site. The plots will be saved as polymerCodeVisual.png in the ``runs/`` directory.
