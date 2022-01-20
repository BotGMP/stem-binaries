#!/usr/bin/python3

print("Benchmark - Artifact Evaluation")

import os

# include stem
os.environ["PATH"] = "./src/:" + os.environ["PATH"]

# check stem
from shutil import which

stem_script = which("stem.sh") is not None
stem_binary = which("stem") is not None

if(stem_script):
    stem_cmd = "stem.sh "
elif(stem_binary):
    stem_cmd = "stem "
else:
    raise RuntimeError("no stem tool available.")

dir = "."
dir_properties = "./properties"
dir_traces = "./traces"
current_project_dir = "."

property = [
    dir_properties + "/property1a.ltlxms",
    dir_properties + "/property1b.ltlxms",
    dir_properties + "/property2a.ltlxms",
    dir_properties + "/property2b.ltlxms",
    dir_properties + "/property3.ltlxms"
]

scenario = [
    current_project_dir + "/../scenario/intersection_T.xodr"
]

trace_empirical = [
    dir_traces + "/Scenario1_Test1.json",
    dir_traces + "/Scenario1_Test2.json",
    dir_traces + "/Scenario2_Test1.json",
    dir_traces + "/Scenario2_Test2.json",
    dir_traces + "/Scenario3_BJ_Test1.json",
    dir_traces + "/Scenario3_BJ_Test2.json",
    dir_traces + "/Scenario3_Z_Test3.json",
    dir_traces + "/Scenario4_Test1.json",
    dir_traces + "/Scenario4_Test2.json",
    dir_traces + "/Scenario4_Test3.json",
]

trace_simulation = [
    dir_traces + "17-06-2021_094104_cropped_v2.json", 
    dir_traces + "17-06-2021_094310_cropped_v2.json", 
    dir_traces + "21-05-2021_183329_cropped.json", 
    dir_traces + "17-06-2021_094104_cropped_v2.json",  
    dir_traces + "17-06-2021_094149_cropped_v2.json", 
    dir_traces + "17-06-2021_094104_cropped_v2.json",  
    dir_traces + "17-06-2021_094240_cropped_v2.json", 
    dir_traces + "17-06-2021_094343_cropped_v2.json", 
    dir_traces + "17-06-2021_094149_cropped_v2.json", 
    dir_traces + "17-06-2021_094240_cropped_v2.json", 
    dir_traces + "17-06-2021_094343_cropped_v2.json"
]

benchmark_empirical = [
(1,1, [(1,'C')] ),
(1,2, [(1,'C')] ),
(2,3, [(1,'C'),(2,'C2')] ),
(2,4, [(1,'C'),(2,'C2')] ),
(3,5, [(1,'C')] ),
(3,6, [(1,'C')] ),
(4,7, [(1,'C')] ),
(5,8, [(1,'C')] ),
(5,9, [(1,'C')] ),
(5,10, [(1,'C')] ),
]

benchmark_simulation = [
(1,1),
(1,2),
(1,3),
(2,4),
(2,5),
(3,6),
(3,7),
(3,8),
(4,9),
(4,10),
(4,11),
]

import subprocess

# generate the monitoring models with unroll enabled for each property
for i in range(len(property)):

    cmd = stem_cmd + " -g -u 12 -i " + property[i] + " -c ./scenario/intersection_T.xodr -o monitoring-model-" + str(i) + ".smt2.tmp"

    print("---")
    print(cmd)

    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    subprocess_return = p.stdout.read()
    #print(subprocess_return)

# simulate the monitoring model with unroll enabled for each trace

for prop_i, trace_i, maps_i in benchmark_empirical:
    cmd = stem_cmd + "-s -m monitoring-model-" + str(prop_i-1) + ".smt2.tmp -t " + trace_empirical[trace_i-1] + " -n \"" + str(maps_i) + "\""

    print("---")
    print(cmd)

    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    subprocess_return = p.stdout.read()
    #print(subprocess_return)

    for ln in str(subprocess_return.decode("utf-8")).splitlines():
        if ln.startswith("Runtime =") or ln.startswith("(Time, Memory) =") or ln.startswith("Checking "):
            print(ln)


