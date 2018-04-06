NXP VPP Compilation Steps:

#######################  ENV variables required:

export PATH=$PATH:<PATH_TO_TOOLCHAIN_GCC_BIN>
export PLATFORM=dpaa

### If using Linaro toolchain
export CROSS_PREFIX=aarch64-linux-gnu

### CPU Tuning for performance optimization, if using CPU other than cortex-A72
export CPU_MTUNE=cortex-A53

export DPDK_PATH= <PATH_TO_DPDK_INSTALL_DIR>
export OPENSSL_PATH= <PATH_TO_OPENSSL_INSTALL_DIR>


###################   Compilation:


$ cd vpp/build-root/
$ make distclean; ./bootstrap.sh 
$ make V=0 PLATFORM=dpaa TAG=dpaa install-rpm

