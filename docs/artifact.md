# Artifact Evaluation

To perform the artififact evaluation please download the stem tool from [releases]() tab or try `stem-binaries-install.sh` script to automatically perform the download and instalation. Proceed with step 1).

1) Download and execute the benchmark script with
```
wget ... && stem-binaries-install.sh
source ...
```

The script will get the proper bundle release (Linux or MacOS).

2) Check if the stem tool can run by checking its current version using
```
stem --version
```
Now, you can try this [guide](guide.md) or proceed to the next step.

3) Run the `benchmark-artifact.sh` with the command
```
./benchmark-artifact.sh
```

4) Check the results in the folder `results`.
