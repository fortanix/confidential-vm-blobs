<!-- TODO (RTE-739, RTE-728): clean up setup -->
# init

The code that builds the `init` executable in this folder, has been taken and adapted from [here](https://github.com/aws/aws-nitro-enclaves-sdk-bootstrap/blob/f718dea60a9d9bb8b8682fd852ad793912f3c5db).

The AWS `init.c` file has adapted as follows:
1. Removed function `init_nsm_driver`: initialization of Nitro Secure Module driver
2. Removed function `enclave_ready`: sending signal to nitro-cli that the enclave has started
3. Removed global vars for above two functions.

To see the diff:
```sh
diff -c10 <(curl https://raw.githubusercontent.com/aws/aws-nitro-enclaves-sdk-bootstrap/f718dea60a9d9bb8b8682fd852ad793912f3c5db/init/init.c) blobs/build_init/init.c
```
