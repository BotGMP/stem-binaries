# Artifact Evaluation

To perform the artifact evaluation, please download the stem tool from the [releases](https://github.com/anmaped/stem-binaries/releases) tab or try `stem-binaries-install.sh` script to automatically perform the download and installation. Proceed with step 1).

1) Download and execute the benchmark script with
```
wget https://raw.githubusercontent.com/anmaped/stem-binaries/master/scripts/stem-binaries-install.sh && bash stem-binaries-install.sh
export PATH=~/stem-binaries:$PATH
```

The script will get the proper bundle release (Linux or macOS).

2) Check if the stem tool can run by checking its current version using
```
stem --version
```
Now, you can try this [guide](guide.md) or proceed to the next step.

3) Run the `benchmark-artifact.sh` with the command
```
~/stem-binaries/scripts/benchmark-artifact.sh
```

4) Check the results in the folder `results`.
