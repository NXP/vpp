# Copyright 2021 NXP
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

prep-dpdk-lib:
ifneq ($(DPDK_PATH),)
	@echo "@@@@ Creating libdpdk.a in $(DPDK_PATH)/lib"
	@cd $(DPDK_PATH)/lib && \
	 echo "GROUP ( $$(ls librte*.a) )" > libdpdk.a && \
	 rm -rf librte*.so librte*.so.* dpdk/*/librte*.so dpdk/*/librte*.so.*
else
	@echo "DPDK Install Path not defined"
endif
