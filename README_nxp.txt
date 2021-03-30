This file contains instruction to cross compile VPP for NXP platforms:


Standalone Build steps:
------------------------
This section details steps required to build VPP in a standalone environment.
Prerequisites before compiling VPP:
Before compiling VPP as a standalone build, following dependencies need to be resolved independently:
 1. DPDK libraries required for packets processing. Please refer section “Standalone build of DPDK Libraries and Applications” for DPDK compilation. Please note that It is required to add “EXTRA_CFLAGS=-fPIC -ftls-model=local-dynamic” in DPDK compilation command to make DPDK libraries compatible with VPP.
 2. OpenSSL libraries.


VPP Compilation:
------------------
	git clone https://source.codeaurora.org/external/qoriq/qoriq-components/vpp
	git checkout -b <local_branch_name> <release_tag> # Replace "<local_branch_name/release_tag>" with LSDK release tag specific information
	export DPDK_PATH=<DPDK installed path>
	export CROSS_TOOLCHAIN= <Path to Toolchain>
	export CROSS_SYSROOT= <Path to Sysrool directory> (Optional)
	export CROSS_PREFIX=aarch64-linux-gnu
	export PLATFORM=dpaa
	export PATH=<toolchain path>/bin:<toolchain path>/aarch64-linux-gnu/bin:$PATH
	export OPENSSL_PATH=<openssl path>
	cd vpp
	make install-dep
	cd build-root
	make distclean

	For debian packages:
	---------------------
	make PLATFORM=dpaa TAG=dpaa vpp-package-deb V=0


After compilation, there will be some "deb" packages generated in vpp/build-root directory. please copy all ".deb" packages to the "/usr/local/vpp" directory in rootfs.


