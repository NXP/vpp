===============================================================================
NXP VPP README FOR LS-DPAA PLATFORMS
===============================================================================

NXP supports VPP on DPAA1 and DPAA2 platoform.
This README provides information about building and executing VPP
for LS platforms

===============================================================================

Components for Build & Execution Environment
--------------------------------------------

To successfully build and execute VPP following components are required:

1. DPDK source code
2. VPP source code
3. Cross compiled toolchain for ARM64 platform

Following information can be used to obtain these components:

     DPDK code
     =========
     Use following command to get the DPDK code
       # git clone ssh://git@sw-stash.freescale.net/gitam/dpdk.git
       # git checkout -b 17.05-qoriq remotes/origin/17.05-qoriq


     VPP code
     ========
     Use following command to get the DPDK code
       # git clone ssh://git@sw-stash.freescale.net/gitam/vpp.git
       # git checkout -b 17.07-qoriq remotes/origin/17.07-qoriq

     Cross compiled toolchain For ARM64
     ==================================
     Get the linaro gcc-6.1 toolchain from:
       # https://releases.linaro.org/components/toolchain/binaries/6.1-2016.08/aarch64-linux-gnu/

===============================================================================

How to Build VPP Applications
------------------------------
1. Build DPDK by having EXTRA_CFLAGS as '-fPIC'. Please follow DPDK documentation to build DPDK.
   Make sure dpdk is build with install directory specified as in below example-
   make install T=arm64-dpaa-linuxapp-gcc DESTDIR=vpp_dpaa EXTRA_CFLAGS='-fPIC'

2. Build OpenSSL. Again please follow DPDK readme to compile OpenSSL

3. Install all the dependencies for VPP
    1. In the VPP directory run 'make install-dep'
    2. Add arm64 architecture support in debian packages using 'sudo dpkg --add-architecture arm64'

3. Build VPP. In the VPP directory
    1. make sure CROSS_COMPILE is not set in the environment
    2. export DPDK_PATH=<dpdk installation path - i.e. path to 'vpp_dpaa'>
    3. export PATH=$PATH:/opt/gcc-linaro-6.1.1-2016.08-x86_64_aarch64-linux-gnu/bin/
    4. cd build-root
    5. make distclean
    6. ./bootstrap
    7. make V=0 PLATFORM=dpaa TAG=dpaa install-deb

   This should create the VPP debian packages with .deb file extensions

===============================================================================

Setting up environment to run VPP on board
------------------------------------------
1. Once the board is up, in case of LS2 run dynamic_dpl.sh and export DPRC;
   and for LS1 run FMC and set the DPAA_NUM_RX_QUEUES as specified in the
   DPDK documentation.

2. Get all the libraries on the board. Copy the binaries from
   '<vpp>/build-root/install-dpaa-aarch64/vpp/lib/*' to '/usr/lib'

3. Get debian packages on the board and run 'dpkg -i *.deb'. This will install VPP.

4. Update the startup.conf file at path /etc/vpp/ to the text within the lines:
     -----------------------------------
	unix {
	  nodaeon
	  log /tmp/vpp.log
	  cli-listen localhost:5002
	  full-coredump
	}

	cpu {
	  main-core 1
	  corelist-workers 2
	}

	dpdk {
	  num-mbufs 5000
	  no-pci
	  dev default {
	        num-rx-queues 7
	  }
	}
     -----------------------------------

   By default VPP reserves 1GB memory from heap. So in case of LS1043 where memory is less
   the below configuration parameter is also required in startup.conf:
        heapsize 200M


Running VPP on host
===================

   Execute following commands to run VPP on host

    1. vpp -c /etc/vpp/startup.conf &
    2. vppctl set int state TenGigabitEthernet0 up
    3. vppctl set int state TenGigabitEthernet1 up
    4. vppctl set interface l2 xconnect TenGigabitEthernet0 TenGigabitEthernet1
    5. vppctl set interface l2 xconnect TenGigabitEthernet1 TenGigabitEthernet0

   'vppctl show interface' command can be used to view all the ports which the
   framework has identified, with their detailed information.

Running VPP with VM
===================

   Execute following commands to run VPP on host

    1. vpp -c /etc/vpp/startup.conf &
    2. vppctl set int state TenGigabitEthernet0 up
    3. vppctl set int state TenGigabitEthernet1 up
    4. vppctl create vhost-user socket /tmp/sock1.sock server
    5. vppctl create vhost-user socket /tmp/sock2.sock server
    6. vppctl set int state VirtualEthernet0/0/0 up
    7. vppctl set int state VirtualEthernet0/0/1 up
    8. vppctl set interface l2 xconnect TenGigabitEthernet0 VirtualEthernet0/0/0
    9. vppctl set interface l2 xconnect VirtualEthernet0/0/0 TenGigabitEthernet0
    10. vppctl set interface l2 xconnect TenGigabitEthernet1 VirtualEthernet0/0/1
    11. vppctl set interface l2 xconnect VirtualEthernet0/0/1 TenGigabitEthernet1

Now use /tmp/sock1.sock & /tmp/sock2.sock in QEMU commands for virtio devices.

Note: Currently with DPAA1 interfaces will be seen as UnknownEthernet0 and so on.
      Please check the ethernet name and stats using command 'vppctl show int'

Code Location: stash
Branch: 17.07-qoriq
Tag:

VPP base version used: Release 17.05
More info on VPP : https://fd.io/
