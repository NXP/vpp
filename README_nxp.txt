NXP VPP Compilation Steps:

###########################################################
ENV variables required:
###########################################################

export PATH=$PATH:<PATH_TO_TOOLCHAIN_GCC_BIN>
export PLATFORM=dpaa
export DPDK_PATH= <PATH_TO_DPDK_INSTALL_DIR>
export OPENSSL_PATH= <PATH_TO_OPENSSL_INSTALL_DIR>


######################
If using Linaro toolchain
######################

export CROSS_PREFIX=aarch64-linux-gnu


######################
CPU Tuning for performance optimization,
if using CPU other than cortex-A72
######################

export CPU_MTUNE=cortex-A53


#######################
While compiling VPP with ARMv8 Crypto support, need to export
an ENV variable to provide path where “libarmv8_crypto.a”
library is created.
######################

export ARMV8_CRYPTO_LIB_PATH= < PATH_TO_CRYPTO_LIB >


###########################################################
Compilation:
###########################################################

$ cd vpp/build-root/
$ make distclean; ./bootstrap.sh 
$ make V=0 PLATFORM=dpaa TAG=dpaa install-rpm




###########################################################
 Runtime  Notes :
###########################################################

- For LS1012, due to less available memory we have to use minimum Hugepages.
  So, please decrease/set the number of Hugepages to 32 (64 MB), using following command.

	$   echo 32 > /proc/sys/vm/nr_hugepages


- We have separate VPP start up Configuration files for LS1012 & LS104x/LS102x

	For LS1012 please use:

		vpp -c /etc/vpp/ls102_startup.conf &

	For LS104x/LS208x please use:

		vpp -c /etc/vpp/startup.conf &



###############################
Running Multiple Worker threads
###############################

- By default, VPP is running for 1 Worker thread modeladn utilizing only 1 CPU. To enable multicore
  please change following parameter to require value in respective "startup.conf" file

  At Line:51 of file "/etc/vpp/startup.conf", change numeric value 1 to number of Worker threads required. 

	workers	1

	

################################
VPP with ARMv8 Crypto support
################################

- Export following variable before runnig the VPP application

	export DPAA_SEC_DISABLE=1

- Uncomment or define following parameter, under DPDK block, in respective startup.conf

	vdev crypto_armv8

