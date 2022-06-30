This file contains instruction to cross compile VPP for NXP platforms:


Standalone Build steps:
-----------------------
This section details steps required to build VPP in a standalone environment.
Prerequisites before compiling VPP:
Before compiling VPP as a standalone build, following dependencies need to be resolved independently:
 1. DPDK libraries required for packets processing. Please refer section “Standalone build of DPDK Libraries and Applications” for DPDK compilation. Please note that It is required to add “EXTRA_CFLAGS=-g -Ofast -fPIC -ftls-model=local-dynamic” in DPDK compilation command to make DPDK libraries compatible with VPP.
 2. OpenSSL libraries.


VPP Compilation:
----------------
	git clone from https://bitbucket.sw.nxp.com/projects/DQNS/repos/vpp/commits
	git checkout -b <local_branch_name> <release_tag> # Replace "<local_branch_name/release_tag>" with LSDK release tag specific information
	export DPDK_PATH=<DPDK installed path>
	export CROSS_TOOLCHAIN= <Path to Toolchain>
	export CROSS_SYSROOT= <Path to Sysrool directory> (Optional)
	export CROSS_PREFIX=aarch64-linux-gnu
	export PLATFORM=dpaa
	export PATH=<toolchain path>/bin:<toolchain path>/aarch64-linux-gnu/bin:$PATH
	export OPENSSL_PATH=<openssl path>
	cd vpp

	Install dependencies one time:
	------------------------------
	make install-dep

	cd build-root
	make distclean

	For debian packages:
	--------------------
	make PLATFORM=dpaa TAG=dpaa vpp-package-deb V=0

After compilation, there will be some "deb" packages generated in vpp/build-root directory. please copy all ".deb" packages to the "/usr/local/vpp" directory in rootfs.


Installing VPP on boards:
-------------------------
	Follow the steps below for installing VPP on the rootfs.
	cd /usr/local/vpp
	dpkg --unpack *.deb
	export LD_LIBRARY_PATH=/usr/lib/vpp_plugins/:$LD_LIBRARY_PATH


On DPAA2 platform:
------------------
	cd /usr/local/dpdk/dpaa2
	. ./dynamic_dpl.sh dpmac.1 dpmac.2
	mkdir /mnt/hugepages
	mount -t hugetlbfs none /mnt/hugepages

	If 2MB hugepages are used:
	--------------------------
	echo 256 > /proc/sys/vm/nrhugepages


On DPAA platform:
-----------------
	mkdir /mnt/hugepages
	mount -t hugetlbfs none /mnt/hugepages

	If 2MB hugepages are used:
	--------------------------
	echo 256 > /proc/sys/vm/nr_hugepages

	fmc -x
	export DPAA_NUM_RX_QUEUES=1
	cd /usr/local/dpdk/dpaa

	Run the FMC script for board specific configuration. For example, for LS1046, run the following command:
		fmc -c usdpaa_config_ls1046.xml -p usdpaa_policy_hash_ipv4_1queue.xml -a
	Return to original working folder:
		cd

Execute VPP:
------------
	vpp -c /etc/vpp/startup.conf.dpkg-new &
	vppctl

Note:
Run 'enable_performance_mode.sh' script if target is to get the performance numbers:
	source /usr/local/dpdk/enable_performance_mode.sh
