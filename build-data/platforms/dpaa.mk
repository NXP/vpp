# Copyright 2018-2021 NXP
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Configuration for NXP DPAA1/DPAA2 ARM64 based platform
MACHINE=$(shell uname -m)

dpaa_mtune = cortex-A72
dpaa_march = "armv8-a+crc+simd+crypto"


ifeq ($(MACHINE),aarch64)
dpaa_arch = native
else
dpaa_arch = aarch64
dpaa_os = linux-gnu
dpaa_target = aarch64-fsl-linux
dpaa_cross_ldflags = \
	-Wl,--dynamic-linker=/lib/ld-linux-aarch64.so.1 \
	-Wl,-rpath=/usr/lib64 \
	-Wl,-rpath=./.libs \
	-Wl,-rpath=$(OPENSSL_PATH)/lib \
	-Wl,-rpath=$(EXTRA_LIBS)
endif

# Re-write Default configuration, if requied
ifneq ($(CROSS_PREFIX),)
# like: aarch64-linux-gnu
dpaa_target = $(CROSS_PREFIX)
endif

ifneq ($(CPU_MTUNE),)
# like: cortex-A53
dpaa_mtune = $(CPU_MTUNE)
endif

#dpaa_native_tools = vppapigen
dpaa_root_packages = vpp

# DPDK configuration parameters
dpaa_uses_dpdk = yes

dpaa_dpdk_make_extra_args = "CONFIG_RTE_KNI_KMOD=n CONFIG_RTE_LIBRTE_PPFE_PMD=n  CONFIG_RTE_EAL_IGB_UIO=n"

# Disable the unused plugins in order to decrease the VPP pacakage size.
vpp_configure_args_dpaa = --without-ipv6sr --with-pre-data=128 --without-libnuma

# Other optional vpp_configure_args
ifneq ($(VPP_CFG_ARGS),)
vpp_configure_args_dpaa += $(VPP_CFG_ARGS)
endif


vpp_cmake_args += -DCMAKE_TOOLCHAIN_FILE=$(PACKAGE_BUILD_DIR)/../../../toolchain.cmake -DCMAKE_C_FLAGS="-g -Ofast -fPIC -march=$(MARCH) -ftls-model=local-dynamic -I$(EXTRA_INC) \
		  -mtune=$(dpaa_mtune) -funroll-all-loops -DCLIB_LOG2_CACHE_LINE_BYTES=6 -I$(OPENSSL_PATH)/include -L$(OPENSSL_PATH)/lib" -DCMAKE_SHARED_LINKER_FLAGS="-L$(OPENSSL_PATH)/lib \
		  -L$(EXTRA_LIBS) -Wl,--dynamic-linker=/lib/ld-linux-aarch64.so.1 \
		  -Wl,-rpath=/usr/lib64 \
		  -Wl,-rpath=./.libs \
		  -Wl,-rpath=$(OPENSSL_PATH)/lib \
"

dpaa_TAG_BUILD_TYPE = release
dpaa_debug_TAG_BUILD_TYPE = debug

vpp_configure_depend += prep-dpdk-lib
