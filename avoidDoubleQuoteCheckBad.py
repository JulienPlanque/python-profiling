import psutil

"""Algorithm servermanufgwp(kgCO2eq) = servertypegwp(kgCO2eq) + cpuunits(unit) x cpubasegwp(kgCO2eq/unit) + ramsize(GB) x ramsizegwp(kgCO2eq/GB)"""
"""MacBook M2 benchmarks"""
servertypegwp = 147
cpubasegwp = 150
ramsizegwp = 3
nbr = 50000000

result = []

for var in [var2 for var2 in range(nbr)]:
    result += ["Renault", "Fiat", "Citroen"]

cpuunits = psutil.cpu_percent(1)
ramsize = psutil.swap_memory().used
servermanufgwp = servertypegwp + cpuunits * cpubasegwp + ramsize * ramsizegwp
print(servermanufgwp)