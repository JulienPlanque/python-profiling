# Python profiling
Python profiling code for Ecocode Challend Rule Checkers.

## Usage
  
### Script Launch Prerequisites 

Build the docker image launched by the check script : 
```
docker build -t mon-script-python .
```
### Launch check
```
./run-script.sh
```

## Setting the coefficients of the formula depending on the execution server

Search in https://github.com/Boavizta/environmental-footprint-data/blob/main/boavizta-data-us.csv, parameter for your execution server for the following variables (present in python script) : 

```
"""Algorithm servermanufgwp(kgCO2eq) = servertypegwp(kgCO2eq) + cpuunits(unit) x cpubasegwp(kgCO2eq/unit) + ramsize(GB) x ramsizegwp(kgCO2eq/GB)"""
"""MacBook M2 benchmarks"""
servertypegwp = 147s
cpubasegwp = 150
ramsizegwp = 3

```